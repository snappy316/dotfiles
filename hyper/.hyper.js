// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: "canary",

    // default font size in pixels for all tabs
    fontSize: 13,

    // font family with optional fallbacks
    fontFamily: "JetBrainsMono Nerd Font",

    // font line height - https://github.com/zeit/hyper/pull/2858
    lineHeight: 1.2,

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: "BLOCK",

    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: false,

    // terminal selection color
    selectionColor: "rgba(216,222,233,0.3)",

    // custom CSS to embed in the main window
    css: "",

    // custom CSS to embed in the terminal window
    termCSS: "",

    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: "",

    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: "",

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: "12px 14px",

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    shell: "/bin/zsh",

    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: ["--login"],

    // for environment variables
    env: {},

    // set to `false` for no bell
    // bell: "SOUND",

    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    // quickEdit: true,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg
    scrollback: 5000,

    hypercwd: {
      initialWorkingDirectory: "~/Projects",
    },

    hyperTabsMove: {
      moveLeft: ["alt+shift+left"],
      moveRight: ["alt+shift+right"],
    },
  },

  // a list of plugins to fetch and install from npm
  plugins: [
    "hypercwd",
    "hyper-font-ligatures",
    "nord-hyper",
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
  },
};
