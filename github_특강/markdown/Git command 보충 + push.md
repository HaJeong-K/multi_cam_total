## Git command 코드

`git remote` : 등록된 `git` 이 있는지

`git remote add origin(이름이 달라도 상관없지만 일반적으로 사용) [git https 주소]`

: repository에 push함





## Git bash command

#### `git bash` 를 통해 올린 `github - a.txt` 로그 캡쳐본

![image-20230714105134075](https://github.com/BEAN0614/multi_cam_total/assets/91309266/f17a5cb6-0f1e-48e9-8f0b-e41fc5ef4815)

![image-20230714105222335](https://github.com/BEAN0614/multi_cam_total/assets/91309266/3eb715b7-6f8a-420c-84cd-ef10ebb8d099)







## 실습3

> `a.txt` 를 해본 것을 바탕으로 `k.txt` 까지 반복해서 작성해본다.
>
> 나는 한 과정에서 반복되는 것을 바로 확인해서 나중엔 `git log --oneline` 으로 확인하다 끝엔 확인해보지 않고 홈페이지를 바로 업로드 해보며 `commit` 이 제대로 작성이 되었는지 확인했다.



#### 홈페이지 업로드 실행 결과

![image-20230714111110533](https://github.com/BEAN0614/multi_cam_total/assets/91309266/c9831860-d39a-4dac-881f-efd709458a81)

[^]: 업로드가 시간순으로 추가할 때 마다 바로바로 올라간 것을 확인할 수 있었다.



## 실습 진행 코드는?

> `a.txt ~ k.txt` 까지 파일을 만들고 업로드 하는 과정을 반복적으로 연습해서 익숙해지는 시간을 가졌다.
>
> `git bash` 를 통해 진행했으며, `Linux command` 를 사용한다.

```git bash
$ pwd
-> 현재 폴더의 위치를 확인한다.

$ mkdir [파일명]
-> 원하는 파일명을 작성해 그 파일을 새롭게 만든다.

$ cd [파일명]/
-> 만들었던 파일로 이동한다.

$ git init
-> git을 부여해 master 상태에서 이어간다.

$ git remote add [저장소 이름] [저장소 주소]
-> 일반적으로 저장소 이름에는 origin 을 많이 사용하며, 주소는 업로드 하고자하는 github의 https 주소를 복사해온다.

$ git remote
-> 저장소 이름을 출력한다.

$ git remote -v
-> fetch와 push가 연결된 저장소 이름과 주소가 함께 출력된다.

$ touch a.txt
-> 0바이트 크기의 파일을 생성할 때 사용하는 linux command 이다.

$ git add a.txt
-> 현재 상태에서 스냅샷을 찍기 위해 대기중인 상태이다.

$ git status
-> commit 하는데에 문제가 없는지 확인해본다.

$ git commit -m "커밋 메세지"
-> git에 올릴 때 사용할 커밋 메세지를 남긴다. 굳이 작성하지 않아도 상관없다.

$ git log / git log --oneline
-> commit이 잘 된 상태인지, 스냅샷을 찍었는지를 함께 출력한다.

$ git push origin master
-> git에 push를 진행한다. 즉, git에 파일을 올린다.
```

위의 코드 중 `touch` 부터 반복하면서 `k.txt` 까지 진행하면 성공이다.
