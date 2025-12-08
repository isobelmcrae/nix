{
  programs.zed-editor = {
    enable = true;

    installRemoteServer = true;

    userSettings = {
      disable_ai = true;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      
      # keys
      base_keymap = "VSCode";
      vim_mode = true;

      # git blame
      git.inline_blame = {
        enabled = true;
        delay_ms = 0;
        min_column = 0;
        show_commit_summary = true;
      };

      # format on save 
      format_on_save = "off";
      
      # visuals
      ui_font_size = 16;
      buffer_font_size = 13.0;
      inlay_hints.enabled = false;

      title_bar = {
        show_branch_icon = true;
        show_project_items = true;
        show_sign_in = false;
        show_menus = false;
      };

      theme = {
        mode = "dark";
        light = "Rosé Pine Dawn";
        dark = "Rosé Pine";
      };

      tabs.show_diagnostics = "all";
      project_panel.entry_spacing = "comfortable";
      cursor_shape = "bar";
      show_whitespaces = "trailing";
      relative_line_numbers = "enabled";
      wrap_guides = [ 80 ];

      # hide unused panels
      collaboration_panel.button = false;
      outline_panel.button = false;
      notification_panel.button = false;
    };

    extensions = [
      "rose-pine-theme"
    ];
  };
}
