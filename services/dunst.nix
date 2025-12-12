{ lib, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = "(0, 400)";
        offset = "(10,10)";
        origin = "top-right";
        
        progress_bar_min_width = 200;
        progress_bar_max_width = 200;
        progress_bar_corner_radius = 2;
        
        padding = 10;
        horizontal_padding = 10;
        frame_width = 2;
        gap_size = 3;
        font = lib.mkForce "JetBrainsMono Nerd Font 10";
        
        # icon_theme = "rose-pine-icons";
        enable_recursive_icon_lookup = true;
        corner_radius = 10;

        background = lib.mkForce "#26233ae6";
        foreground = lib.mkForce "#e0def4";
      };

      urgency_low = {
        background = lib.mkForce "#26273de6";
        highlight = lib.mkForce "#31748f";
        frame_color = lib.mkForce "#31748f";
        # default_icon = "dialog-information";
        format = "<b><span foreground='#31748f'>%s</span></b>\n%b";
      };

      urgency_normal = {
        background = lib.mkForce "#362e3ce6";
        highlight = lib.mkForce "#f6c177";
        frame_color = lib.mkForce "#f6c177";
        # default_icon = "dialog-warning";
        format = "<b><span foreground='#f6c177'>%s</span></b>\n%b";
      };

      urgency_critical = {
        background = lib.mkForce "#35263de6";
        highlight = lib.mkForce "#eb6f92";
        frame_color = lib.mkForce "#eb6f92";
        default_icon = "dialog-error";
        format = "<b><span foreground='#eb6f92'>%s</span></b>\n%b";
      };
    };
  };
}
