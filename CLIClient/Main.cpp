
#include <string>
#include <cstring>
#include <cstdio>
#include <ncurses.h>

using std::string;

int main(int argc, char** argv)
{
    initscr();
    noecho();
    raw();
    keypad(stdscr, true);

    int row, col;
    char title[] = "Acid Chat";
    getmaxyx(stdscr, row, col);
    mvprintw(0, (col - strlen(title))/2, "%s", title);
    refresh();

    WINDOW* winFriendsList;
    winFriendsList = newwin(0, 40, 1, 0);
    box(winFriendsList, 0, 0);
    mvwprintw(winFriendsList, 0, 2, " Friends List ");
    wrefresh(winFriendsList);

    WINDOW* winChat;
    winChat = newwin(0, col - 40, 1, 40);
    box(winChat, 0, 0);
    mvwprintw(winChat, 0, 2, " Current Chat ");
    wrefresh(winChat);

    move(0, 0);

    getch();
    endwin();

    return 0;
}
