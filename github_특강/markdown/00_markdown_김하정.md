# 마크다운(Markdown)

> 일반 텍스트 형식 구문을 사용하는 마크업 언어의 일종으로 사용법이 쉽고 간결하여 빠르게 문서 정리를 할 수 있습니다.
> 단, 모든 HTML 마크업을 대체하지는 않습니다.



# 1. 문법

## 1.1 Header

> 헤더는 제목을 표현할 때 사용합니다.
>
> 단순히 글자의 크기를 표현하는 것이 아닌 의미론적인 중요도를 나타냅니다.

- `<h1>`부터 `<h6>`까지 표현 가능합니다.
- `#`의 개수로 표현하거나 `<h1></h1>`의 형태로 표현 가능합니다.



# h1 태그입니다.

## h2 태그입니다.

### h3 태그입니다.

#### h4 태그입니다.

##### h5 태그입니다.

###### h6 태그입니다.



## 1.2 List

> 목록을 나열할 때 사용합니다. 순서가 필요한 항목과 그렇지 않은 항목으로 구분할 수 있습니다.
>
> 순서가 있는 항목 아래 순서가 없는 항목을 지정할 수 있으며 그 반대도 가능합니다.

- 순서가 없는 목록
  * `1.` 을 누르고 스페이스바를 누르면 생성할 수 있습니다.
  * `tab` 키를 눌러서 하위항목을 생성할 수 있고 `shift + tab` 키를 눌러서 상위 항목으로 이동할 수 있습니다.
- 순서가 있는 목록
  * `-` (하이픈)을 쓰고 스페이스바를 누르면 생성할 수 있습니다.
  * `tab` 키를 눌러서 하위 항목을 생성할 수 있고 `shift + tab` 키를 눌러서 상위 항목으로 이동할 수 있습니다.

1. 순서가 있는 첫번째 항목
2. 순서가 있는 두번째 항목
   1. 순서가 있는 하위 첫번째 항목
   2. 순서가 있는 하위 두번째 항목



- 순서가 없는 항목
- 순서가 없는 항목
  - 순서가 없는 하위 항목
  - 순서가 없는 하위 항목



## 1.3 Code Block

> 코드 블럭은 작성한 코드를 정리하거나 강조하고 싶은 부분을 나타낼 때 사용합니다.
>
> 인라인과 블럭 단위로 구분할 수 있습니다.

- Inline
  - 인라인 블럭으로 처리하고 싶은 부분을 ` (백틱) 으로 감싸줍니다.
- Block
  - \`(백틱) 을 3번 입력하고 `Enter` 를 눌러 생성합니다.



`add` 한 요소를 remote 저장소에 올리려면 `$ git push origin  master` 를 터미널에 입력합니다.



```
$ git add .
$ git commit -m "first commit"
$ git push origin master
```



## 1.4 Image

> 로컬에 있는 이미지를 삽입하거나 이미지 링크를 활용하여 이미지를 나타낼 때 사용합니다.

- `![]()` 을 작성하고 `()` 안에 이미지 주소를 입력합니다. `[]` 안에는 이미지 파일의 이름을 작성합니다.
- 로컬에 이미지 파일을 저장한 경우 절대 경로가 아닌 상대 경로를 사용하여 이미지를 저장합니다.

![git & github mark](data:image/png;base64,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)

## 1.5 Link

> 특정 주소로 링크를 걸 때 사용합니다.

- `[]()`을 작성하고 `()` 안에 링크 주소를 작성하고 `[]` 안에 어떤 링크 주소인지 작성합니다.



[git 공식문서](https://git-scm.com/book/ko/v2)

[github 공식문서](https://docs.github.com/ko)



## 1.6 Table

> 표를 작성하여 요소를 구분할 수 있습니다.

- `|` (파이프) 사이에 컬럼을 작성하고 `Enter` 를 입력합니다.
- 마지막 컬럼을 작성하고 뒤에 `|` 를 붙여줍니다.

| working directory | statging area | remoe repo |
| ----------------- | ------------- | ---------- |
| working tree      | index         | history    |
| working copy      | cache         | tree       |



## 1.7 기타

**인용문**

- `>` 을 입력하고 `Enter` 키를 누릅니다.

> git은 컴퓨터 파일의 변경사항을 추적하고 여러 명의 사용자들 간에 해당 파일들의 작업을 조율하기 위한 분산 버전 관리 시스템이다.

- 인용문 안에 인용문을 작성하면 중첩해서 사용할 수 있습니다.

> $ git add .
>
> >$ git commit -m "first commit"
> >
> >> $ git push origin master



**수평선**

- `---` , `***` , `___`  을 입력하여 작성합니다.

Working Direstory

---

Staging Area

***

Remote Repository

___



**강조**

- 이탤릭체는 해당 부분을 `*` 혹은 `_` (언더바) 로 감싸줍니다.
- 보드체는 해당 부분을 `**` 혹은 `__` (언더바 2개)로 감싸줍니다.
- 취소선을 `~~` 표시를 사용합니다.

이것은 *이탤릭체* 입니다.

이것은 __보드체__ 입니다.

이것은 ~~취소선~~ 입니다.



## 2. 과제

> 현재의 pdf 문서를 마크다운 문법을 활용하여 `00_markdown_name.md` 로 만들어보세요.
