//
//  main.cpp
//  GenerateDB
//
//  Created by Ludwig on 15/12/12.
//  Copyright © 2015年 Ludwig. All rights reserved.
//


#include <iostream>
#include <fstream>
#include <string>
#include <sqlite3.h>

using namespace std;

int rc;
char *errMsg;
sqlite3 *pDB;

void convert(char *str)
{
    int len = strlen(str);
    for (int i = 0; i < len; i++) {
        if (str[i] == '\'') {
            for (int j = len; j > i; j--)
            {
                str[j] = str[j-1];
            }
            i++;
            len++;
        }
    }
}

void deletestr(char *buf, char *pattern)
{
    int buflen = strlen(buf);
    int plen = strlen(pattern);
    int p;
    for (p = 0; p < buflen; p++) {
        if (buf[p] == pattern[0]) {
            int k;
            for (k = 0; k < plen; k++) {
                if (buf[p+k] != pattern[k]) {
                    break;
                }
            }
            if (k == plen) {
                for (int i = p + plen; i < buflen; i++) {
                    buf[i-plen] = buf[i];
                }
                for (int i = buflen - plen; i < buflen; i++) {
                    buf[i] = 0;
                }
                p--;
                buflen -= plen;
            }
        }
    }
    
}

int main(int argc, const char * argv[]) {
    // insert code here...
    
    string path = "dict.db";
    rc = sqlite3_open(path.c_str(), &pDB);
    
    if (rc) {
        cout << "OPEN FAILURE" << endl;
        return 0;
    }
    
    rc = sqlite3_exec(pDB, "create table oxford(en text primary key, symbol text, ch text);", 0, 0, &errMsg);
    
    if (rc == SQLITE_OK) {
        cout << "CREATE SUCCESS" << endl;
    }
    else {
        cout << "CREATE FAILURE" << endl;
    }
    
    ifstream in("jian.txt");
    if (!in) {
        cout << "ABORT" << endl;
        return 0;
    }
    
    char buf[1000];
    in.getline(buf, 1000);
    rc = sqlite3_exec(pDB, "insert into oxford values('7-24', null, '指的是一星期7天，每天24小时，一般表示提供不间断的服务也表示为7*24或7/24');", 0, 0, &errMsg);
    if (rc != SQLITE_OK) {
        cout << "FAILURE 7-24" << endl;
        cout << errMsg << endl;
    }
    
    while (!in.eof()) {
        in.getline(buf, 1000);
        int p0 = 0;
        char en[100];
        char symbol[100];
        char ch[800];
        
        deletestr(buf, "</font>");
        deletestr(buf, "<br>");
        deletestr(buf, "<font color=green>");
        deletestr(buf, "<font color=red>");
        deletestr(buf, "<font color=lime>");
        deletestr(buf, "<font color=purple>");
        deletestr(buf, "<font color=teal>");
        deletestr(buf, "<font color=blue>");
        deletestr(buf, "<font color=olive>");
        
        while (buf[p0] != '\t') {
            p0++;
        }
        int p2 = p0;
        while (buf[p2] == ' ' || buf[p2] == '\t') {
            p2--;
        }
        p2++;
        
        memcpy(en, buf, p2);
        
        int wordlen = p2;
        int buflen = strlen(buf);
        
        while (buf[p0] != '[' && p0 < buflen) {
            p0++;
        }
        
        if (buf[p0+1] == '<' && buf[p0+2] == 'f' && buf[p0+3] == 'o') {
            p0 += 7;
            while (buf[p0] == ' ' || buf[p0] == '\t') {
                p0++;
            }
            int p1 = p0;
            while (buf[p1] != ']') {
                p1++;
            }
            while (buf[p1] == ' ' || buf[p1] == '\t') {
                p1--;
            }
            
            memcpy(symbol, &buf[p0], p1-p0);
            
            p1++;
            while (buf[p1] == ' ' || buf[p1] == '\t') {
                p1++;
            }
            
            memcpy(ch, &buf[p1], buflen-p1-1);
            
            convert(en);
            convert(symbol);
            convert(ch);
            char command[500];
            sprintf(command, "insert into oxford values('%s', '%s', '%s');", en, symbol, ch);
            rc = sqlite3_exec(pDB, command, 0, 0, &errMsg);
            if (rc != SQLITE_OK) {
                cout << "FAILURE " << en << endl;
                cout << errMsg << endl;
            }
        }
        else {
            while (buf[p2] == ' ' || buf[p2] == '\t') {
                p2++;
            }
            p2 += wordlen;
            while (buf[p2] == ' ' || buf[p2] == '\t') {
                p2++;
            }
            memcpy(ch, &buf[p2], buflen-p2-1);
            
            convert(en);
            convert(ch);
            char command[500];
            sprintf(command, "insert into oxford values('%s', null, '%s');", en, ch);
            rc = sqlite3_exec(pDB, command, 0, 0, &errMsg);
            if (rc != SQLITE_OK) {
                cout << "FAILURE " << en << endl;
                cout << errMsg << endl;
            }
        }
        
        memset(en, 0, 100);
        memset(symbol, 0, 100);
        memset(ch, 0, 800);
        memset(buf, 0, 1000);
    }
    
    in.close();
    
    sqlite3_close(pDB);
    
    return 0;
}

