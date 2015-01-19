Deface::Override.new(
  virtual_path: "spree/admin/shared/_configuration_menu",
  name: "mail_settings_admin_configurations_menu",
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
  text: "<%= configurations_sidebar_menu_item Spree.t(:mail_method_settings), edit_admin_mail_method_url %>"
)
