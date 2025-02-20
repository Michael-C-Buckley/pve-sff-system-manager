_: {
  # Enable no password for sudo group members
  environment.etc."sudoers.d/sudo-nopasswd".text = ''
    %sudo ALL=(ALL) NOPASSWD: ALL
  '';
}