
#include <cstdio>
#include <gtkmm.h>
#include <vector>
#include <string>

using std::vector;
using std::string;

Gtk::Widget* findWidgetByName(Gtk::Widget* pParent, Glib::ustring name)
{
    //printf("Widget: %s\n", pParent->get_name().c_str());
    if (pParent->get_name() == name)
    {
        return pParent;
    }

    if (auto pBin = dynamic_cast<Gtk::Bin*>(pParent))
    {
        Gtk::Widget* pChild = pBin->get_child();
        return findWidgetByName(pChild, name);
    }

    if (auto pContainer = dynamic_cast<Gtk::Container*>(pParent))
    {
        const vector<Gtk::Widget*>& children = pContainer->get_children();
        //printf("Children: %d\n", children.size());
        for (Gtk::Widget* pChild : children)
        {
            Gtk::Widget* pFound = findWidgetByName(pChild, name);
            if (pFound != nullptr)
            {
                return pFound;
            }
        }
    }

    return nullptr;
}

struct FriendsListEntry
{
    enum class Status
    {
        Offline,
        Available,
        Away,
    };

    FriendsListEntry() :
        m_ID(-1)
    { }

    FriendsListEntry(const int& id, const Glib::ustring& name, const Status& status) :
        m_ID(id),
        m_Name(name),
        m_Status(status)
    { }

    int m_ID;
    Glib::ustring m_Name;
    Status m_Status;

};

class ModelColumns : public Gtk::TreeModel::ColumnRecord
{
public:

    ModelColumns()
    {
        add(m_col_id);
        add(m_col_status);
        add(m_col_name);
    }

    Gtk::TreeModelColumn<int> m_col_id;
    Gtk::TreeModelColumn<FriendsListEntry::Status> m_col_status;
    Gtk::TreeModelColumn<Glib::ustring> m_col_name;
};

int main(int argc, char** argv)
{
    auto app = Gtk::Application::create(argc, argv, "org.gtkmm.acidchat.base");

    Glib::RefPtr<Gtk::Builder> builder = Gtk::Builder::create_from_file("FriendsList.glade");

    Gtk::ApplicationWindow* pWindow = nullptr;
    builder->get_widget("win_Main", pWindow);
    pWindow->set_default_size(300, 600);

    vector<string> contacts = { "Stephen", "Freddy", "George", "Alex", "Sam" };

    Gtk::TreeView* pFriendsList = dynamic_cast<Gtk::TreeView*>(findWidgetByName(pWindow, "list_FriendsList"));
    if (pFriendsList)
    {
        ModelColumns m_Columns;
        Glib::RefPtr<Gtk::ListStore> m_refTreeModel = Gtk::ListStore::create(m_Columns);
        pFriendsList->set_model(m_refTreeModel);

        pFriendsList->append_column("Status", m_Columns.m_col_status);
        pFriendsList->append_column("Name", m_Columns.m_col_name);
        m_refTreeModel->set_sort_column(m_Columns.m_col_name, Gtk::SORT_ASCENDING);

        int id = 0;
        for (auto contact : contacts)
        {
            Gtk::TreeModel::Row row = *(m_refTreeModel->append());
            row[m_Columns.m_col_id] = id++;
            row[m_Columns.m_col_status] = FriendsListEntry::Status::Available;
            row[m_Columns.m_col_name] = contact;
        }
    }

    return app->run(*pWindow);
}
