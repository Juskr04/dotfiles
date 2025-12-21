#include <stdlib.h>
#include <stdio.h>

int main() {
    //system("app_launcher");
    system("foot -W 150x12 -a foot_app_launcher -e sh -c 'find /usr/share/applications -type f -iname \"*.desktop\" -printf \"%p\\n\" | fzf --layout=reverse | xargs cat | grep -m1 Exec > /tmp/app_launcher'");

    FILE *fp = fopen("/tmp/app_launcher", "r");
    if (fp) 
    {
        char output[200];
        char app_name[30];
        fgets(output, sizeof(output), fp);
        int i = 5;
        int j = 0;
        while((output[i] != '%') && (output[i] != '\n'))
        {
            app_name[j] = output[i];
            i++;
            j++;
        }
        app_name[j] = '\0';
        system(app_name);
        fclose(fp);
    }
    return 0;
}
