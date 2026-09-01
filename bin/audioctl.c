#include <CoreAudio/CoreAudio.h>
#include <CoreFoundation/CoreFoundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

// Minimal CoreAudio wrapper to list devices and set the default input/output
// device by name. Same approach as the Swift version, just plain C so it
// only depends on clang + the system frameworks — no Swift toolchain needed.

static AudioDeviceID *getAllDevices(UInt32 *outCount) {
    AudioObjectPropertyAddress addr = {
        kAudioHardwarePropertyDevices,
        kAudioObjectPropertyScopeGlobal,
        kAudioObjectPropertyElementMain
    };
    UInt32 dataSize = 0;
    AudioObjectGetPropertyDataSize(kAudioObjectSystemObject, &addr, 0, NULL, &dataSize);
    UInt32 count = dataSize / (UInt32)sizeof(AudioDeviceID);
    AudioDeviceID *ids = malloc(dataSize);
    AudioObjectGetPropertyData(kAudioObjectSystemObject, &addr, 0, NULL, &dataSize, ids);
    *outCount = count;
    return ids;
}

static void getDeviceName(AudioDeviceID id, char *buf, size_t bufSize) {
    AudioObjectPropertyAddress addr = {
        kAudioObjectPropertyName,
        kAudioObjectPropertyScopeGlobal,
        kAudioObjectPropertyElementMain
    };
    CFStringRef name = NULL;
    UInt32 dataSize = sizeof(name);
    OSStatus status = AudioObjectGetPropertyData(id, &addr, 0, NULL, &dataSize, &name);
    if (status != noErr || name == NULL) {
        strncpy(buf, "Unknown", bufSize);
        return;
    }
    CFStringGetCString(name, buf, bufSize, kCFStringEncodingUTF8);
    CFRelease(name);
}

static int hasStreams(AudioDeviceID id, AudioObjectPropertyScope scope) {
    AudioObjectPropertyAddress addr = {
        kAudioDevicePropertyStreams,
        scope,
        kAudioObjectPropertyElementMain
    };
    UInt32 dataSize = 0;
    AudioObjectGetPropertyDataSize(id, &addr, 0, NULL, &dataSize);
    return dataSize > 0;
}

static AudioDeviceID getDefaultDevice(AudioObjectPropertySelector selector) {
    AudioObjectPropertyAddress addr = {
        selector,
        kAudioObjectPropertyScopeGlobal,
        kAudioObjectPropertyElementMain
    };
    AudioDeviceID deviceID = 0;
    UInt32 dataSize = sizeof(deviceID);
    AudioObjectGetPropertyData(kAudioObjectSystemObject, &addr, 0, NULL, &dataSize, &deviceID);
    return deviceID;
}

static int setDefaultDevice(AudioObjectPropertySelector selector, AudioDeviceID id) {
    AudioObjectPropertyAddress addr = {
        selector,
        kAudioObjectPropertyScopeGlobal,
        kAudioObjectPropertyElementMain
    };
    UInt32 dataSize = sizeof(id);
    OSStatus status = AudioObjectSetPropertyData(kAudioObjectSystemObject, &addr, 0, NULL, dataSize, &id);
    return status == noErr;
}

static void lowercaseInPlace(char *s) {
    for (; *s; s++) *s = (char)tolower((unsigned char)*s);
}

static int findDevice(const char *query, AudioObjectPropertyScope scope, AudioDeviceID *outID) {
    UInt32 count;
    AudioDeviceID *ids = getAllDevices(&count);

    char q[256];
    strncpy(q, query, sizeof(q) - 1);
    q[sizeof(q) - 1] = '\0';
    lowercaseInPlace(q);

    int found = 0;
    char nameBuf[256];
    for (UInt32 i = 0; i < count; i++) {
        if (!hasStreams(ids[i], scope)) continue;
        getDeviceName(ids[i], nameBuf, sizeof(nameBuf));
        char lower[256];
        strncpy(lower, nameBuf, sizeof(lower) - 1);
        lower[sizeof(lower) - 1] = '\0';
        lowercaseInPlace(lower);
        if (strstr(lower, q)) {
            *outID = ids[i];
            found = 1;
            break;
        }
    }
    free(ids);
    return found;
}

static void listDevices(void) {
    UInt32 count;
    AudioDeviceID *ids = getAllDevices(&count);
    AudioDeviceID curIn = getDefaultDevice(kAudioHardwarePropertyDefaultInputDevice);
    AudioDeviceID curOut = getDefaultDevice(kAudioHardwarePropertyDefaultOutputDevice);
    char nameBuf[256];
    for (UInt32 i = 0; i < count; i++) {
        getDeviceName(ids[i], nameBuf, sizeof(nameBuf));
        printf("%u\t%s\t[", ids[i], nameBuf);
        int any = 0;
        if (hasStreams(ids[i], kAudioObjectPropertyScopeInput)) { printf("input"); any = 1; }
        if (hasStreams(ids[i], kAudioObjectPropertyScopeOutput)) { printf("%soutput", any ? ", " : ""); any = 1; }
        if (ids[i] == curIn) { printf("%sDEFAULT-IN", any ? ", " : ""); any = 1; }
        if (ids[i] == curOut) { printf("%sDEFAULT-OUT", any ? ", " : ""); }
        printf("]\n");
    }
    free(ids);
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage:\n  audioctl list\n  audioctl input <name-substring>\n  audioctl output <name-substring>\n");
        return 1;
    }
    if (strcmp(argv[1], "list") == 0) {
        listDevices();
        return 0;
    }
    if (strcmp(argv[1], "input") == 0 || strcmp(argv[1], "output") == 0) {
        if (argc < 3) {
            fprintf(stderr, "Missing device name\n");
            return 1;
        }
        int isInput = strcmp(argv[1], "input") == 0;
        AudioObjectPropertyScope scope = isInput ? kAudioObjectPropertyScopeInput : kAudioObjectPropertyScopeOutput;
        AudioObjectPropertySelector selector = isInput ? kAudioHardwarePropertyDefaultInputDevice : kAudioHardwarePropertyDefaultOutputDevice;
        AudioDeviceID id;
        if (!findDevice(argv[2], scope, &id)) {
            fprintf(stderr, "No matching %s device found for '%s'\n", argv[1], argv[2]);
            return 1;
        }
        char nameBuf[256];
        getDeviceName(id, nameBuf, sizeof(nameBuf));
        if (setDefaultDevice(selector, id)) {
            printf("OK: %s -> %s\n", argv[1], nameBuf);
            return 0;
        }
        fprintf(stderr, "FAILED to set %s device\n", argv[1]);
        return 1;
    }
    fprintf(stderr, "Unknown command '%s'\n", argv[1]);
    return 1;
}
