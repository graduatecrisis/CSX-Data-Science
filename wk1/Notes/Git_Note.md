Reference Link:
[Git筆記](http://tech-marsw.logdown.com/blog/2013/08/16/git-notes-github),
[Progress Bar](https://progressbar.tw/posts/1)

### Git 本機指令

1.  本機端初始化
    -   使用者名稱:`git config --global user.name "Yourname"`
    -   電子信箱:`git config --global user.email “Youremail”`
    -   定義本機作者，與remote repository使用者不同沒有關係
2.  建立本機Repository
    -   可先於想要的位置建立新資料夾，並將此資料夾設為Repository，EX:
        *Desktop--CSX\_Data\_Science(Repository)*
3.  進入資料夾:`cd`
    -   進入桌面:`cd Desktop/`
    -   進入CSX資料夾:`cd CSX\ Data\ Science/`
    -   **Tip**: 打完資料夾開頭可直接按`Tab`完成路徑
    -   此時可由下方顯示狀態確定位置
4.  建立Repository:`git init`
    -   下方路徑結尾將顯示\`mater
    -   查看master狀態:`git status`
    -   查看master連線:`git remote`
    -   查看此資料夾內容:`ls`
5.  新增文件至Staged:`git add <file>`
    -   從Staged中移除:`git remove HEAD<file>`
    -   將所有有更動檔案加入:`git add -f--all`
    -   **只要有modified就要重新add**
6.  寫入紀錄檔:`git commit -m"filename"`

7.  Git Log(待補)

8.  Vim語法(待補)

### Git遠端連線

有兩種方式，此處先記錄從遠端clone的方式

#### GitHub Repository Clone

此動作會在所選的資料夾(可不為本機master)中建立遠端Rep的目錄，並下載全部程式，此時於本機所作之更動需視為branch(建立新branch增修檔案)，commit後與master
merge，才可進行push

1.  進入本地資料夾後，建立遠端目錄:`git clone<url>`

2.  於本地資料夾建立branch進行增修
    -   新增branch:`git branch<branchname>`
    -   切換到此branch:`git checkout<branchname>`
3.  修改檔案

4.  將檔案`git add<filename>`和`git commit -m`提交

5.  切換回master準備merge
    -   切回master:`git checkout master`
    -   將master與branch做merge`git merge<branchname>`
6.  上傳:`git push`

7.  若GitHub資料夾有更新，記得下載最新版本至本地端:`git pull`
