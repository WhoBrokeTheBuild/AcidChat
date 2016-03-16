
#include <cstdio>
#include <gtkmm.h>

int main(int argc, char** argv)
{
    auto app =
        Gtk::Application::create(argc, argv,
          "org.gtkmm.examples.base");

      Glib::RefPtr<Gtk::Builder> builder = Gtk::Builder::create_from_file("FriendsList.glade");
      Gtk::ApplicationWindow* pWindow = nullptr;

      builder->get_widget("win_Main", pWindow);
      pWindow->set_default_size(300, 600);

      return app->run(*pWindow);
}
