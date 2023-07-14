## CLI 버전관리

- GUI로 제어할 수 없는 서버 환경에서도 사용가능

- 초기버전의 파일을 올린 상태에서 수정을 하면 `git` 에서 초기버전을 가져올 수 있다.

![image-20230714092157099](https://github.com/BEAN0614/multi_cam_total/assets/91309266/596feb65-2047-4d34-932b-4b18601cf713)


##  *알고가야할 지식!*

- Working tree: 작업테이블
- Staging Area: 커밋 버전하고 싶은 걸 올리는 곳
- Repository: 스테이징 에어리어 커밋할 때 저장소

```
$ pwd
$ cd [파일명]
$ mkdir [파일명]
$ ls -al
$ git init
$ git status
$ cat hello1.text
$ nano hello1.txt
$ git add hello1.txt
$ git commit -m "message 1"
$ git log
$ git log --stat
$ git log --oneline
```



## Git Backup

#### 자유롭지만 어려운 방법 VS. 제한적이지만 쉬운 방법



## 자유롭지만 어려운 방법이란?

> 직접 백업 서버를 구축하면 됨
>
> 즉, 새로운 컴퓨터를 하나 장만해서 모든 자료를 옮겨야 함
>
> /+ 항상 켜둬야 함



## 제한적이지만 쉬운 방법이란?

> 인터넷에 연결되어 원격으로 사용가능한 서버를 임대하는  __git hosting__ 을 사용함
>
> 이 방법으로 우리는 특별한 지식 없이 원격 백업 서비스를 이용 가능함



#### 일반적으로 우리가 알고있는 백업

![image-20230713171030476](https://github.com/BEAN0614/multi_cam_total/assets/91309266/a72f05e1-6dbb-4cc5-8088-8a525c84778c)

원래 사용하는 지역 저장소에서 원격 저장소로 자료를 넣고 회사에서 사용하는 컴퓨터에서 이 자료들을 다 가져오면 모든 컴퓨터는 같은 상태로 사용가능함

PULL과 PUSH의 연속으로 백업상태를 최신화함 + CLONE으로 다른 컴퓨터에 복제 가능

__원격저장소가 가장 중심이 됨__





## Git 협업

> github 특강 1일차에 git terminal에 입력했던 01번 markdown을 참고해 파일을 생성하고,
>
> 생성된 파일을 `push` 하는 것이 기본

- `github /> settings /> collaboration` 에서 초대 수락을 해야함



= "https://www.youtube.com/watch?v=hou5mXBN9gA" >/ 생활코딩 유튜브 참고.

![image-20230713175601055](https://github.com/BEAN0614/multi_cam_total/assets/91309266/9fc582b4-6e49-4185-88f9-cce191ca66b8)

*연결됨을 확인할 수 있는 장면*

(단, 2개가 먼저 연결 된 상태에서 한쪽에서 하나를 추가로 연결을 한다면 다른 쪽에서는  PULL을 통해 끌어와야 함.)

- `git pull = git fetch`

- fetch를 통해서 merge 시킴
