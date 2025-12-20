{ lib, ... }:

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
      inlay_hints.enabled = false;

      title_bar = {
        show_branch_icon = true;
        show_project_items = true;
        show_sign_in = false;
        show_menus = false;
      };

      theme = lib.mkForce "Rosé Pine";
      buffer_font_size = lib.mkForce 12;

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
  };
}
