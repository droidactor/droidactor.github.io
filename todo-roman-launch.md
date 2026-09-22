# todo — Dotori Roman Numerals 출시 후 사이트 작업

`roman`(`com.droidactor.roman`)은 **처리방침 항목만 먼저** 올라가 있고 나머지 사이트 작업은 하지
않았다. 이 문서는 그 나머지를 출시 시점에 한 묶음으로 처리하기 위한 목록이다.

## 왜 지금 다 하지 않았나

게시본에 앵커가 있어야 `play.sh check roman` 의 `published-urls` 가 통과하고, 그것이 AAB 업로드
전에 필요했다. 반면 홈 카드·제품 페이지는 **미출시 상태로 만들면 `badge soon` 만 붙고**, 출시하는
날 배지를 스토어 배지로 바꾸러 같은 파일을 다시 열어야 한다. 두 번 손대는 대신 출시 시점에 모으는
쪽을 골랐다(2026-09-13, 커밋 `edc76fc`).

**`yt-downloader` 가 지금 그 상태다** — 카드와 제품 페이지는 있고 `badge soon` 이 붙어 있다.
즉 아래 1~7 을 먼저 하고 출시 후 8 을 하는 순서도 가능하다. 순서는 자유지만 **7(역방향 링크)을
빠뜨리면 새 앱으로 들어가는 내부 링크가 홈 카드뿐**이라 크롤러가 한 경로로만 본다(`bt-mouse` 때
실제로 빠뜨렸다 — `README.md` 의 "고칠 때" 참조).

## 이미 되어 있는 것

- `index.html` · `ko/index.html` 의 `<div class="policy" id="privacy-roman">` 두 벌
- `README.md` 앵커 목록에 `roman` 추가
- 두 홈 페이지의 `sitemap.xml` `lastmod`

## 확정값

| 항목 | 값 |
|---|---|
| app key | `roman` |
| 패키지 | `com.droidactor.roman` |
| 제품 경로 | `/apps/roman/` · `/ko/apps/roman/` |
| 영문 이름 | `Dotori Roman Numerals` |
| 한국어 이름 | `도토리 로마 숫자 변환기` |
| 처리방침 앵커 | `#privacy-roman` (완료) |
| Play 주소 | `https://play.google.com/store/apps/details?id=com.droidactor.roman&hl=en` (한국어 카드는 `hl=ko`) |

카드 이모지는 아직 안 정했다. 런처 아이콘이 폐허 콜로세움 + 로마자 V 이므로 `🏛️` 가 가깝다.

## 할 일

기준은 `README.md` 의 "고칠 때 → 앱을 추가하면" 이고, 아래는 그것을 `roman` 에 맞춰 푼 것이다.
**참고할 기존 앱은 `lgtv`** — 가장 최근에 같은 절차를 밟았다.

### 1. 홈 카드 2개

`index.html` · `ko/index.html` 의 `<article class="card">`. `lgtv` 카드를 그대로 본뜬다.

```html
<article class="card">
  <div class="icon" aria-hidden="true">🏛️</div>
  <h3><a href="/apps/roman/"><span class="dotori">Dotori</span> Roman Numerals</a></h3>
  <div class="pkg">com.droidactor.roman</div>
  <p class="desc">…</p>
  <div class="foot">
    <span class="badge soon">Coming soon</span>   <!-- 출시하면 8 에서 교체 -->
    <a href="/apps/roman/">Details</a>
    <a href="#privacy-roman">Privacy</a>
  </div>
</article>
```

카드 순서는 JSON-LD `position` 과 맞춰야 한다(아래 6).

### 2. 처리방침 항목 2개 — **완료**

### 3. 제품 페이지 2개

`apps/roman/index.html` · `ko/apps/roman/index.html`. `apps/lgtv/index.html` 을 골격으로 쓴다.

- **처리방침 전문을 복사하지 않는다.** 요약 + `/#privacy-roman` 링크만 둔다(`README.md` 규약).
- 사양표의 `Status`/`상태` 행은 출시 전 "준비 중", 출시 후 발행 문구로 바꾼다(8 과 함께).
- 내용 재료는 코드 저장소의 `apps/roman/play/store-listing/{en-US,ko-KR}.md` 에 이미 있다.

### 4. `sitemap.xml` URL 2개

`lgtv` 블록과 같은 모양. `hreflang` 3줄을 빠뜨리지 않는다.

```xml
<url>
  <loc>https://droidactor.github.io/apps/roman/</loc>
  <lastmod>YYYY-MM-DD</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.8</priority>
  <xhtml:link rel="alternate" hreflang="en" href="https://droidactor.github.io/apps/roman/"/>
  <xhtml:link rel="alternate" hreflang="ko" href="https://droidactor.github.io/ko/apps/roman/"/>
  <xhtml:link rel="alternate" hreflang="x-default" href="https://droidactor.github.io/apps/roman/"/>
</url>
```

`/ko/apps/roman/` 쪽 블록도 같은 방식으로 한 벌 더.

### 5. 권한 표

처리방침 §4 권한 표(두 언어)에 새 권한이 생기면 행을 더한다. **`roman` 은 새 권한이 없다** —
`VIBRATE`(키 되먹임)와 공용 광고 모듈의 `INTERNET`·`ACCESS_NETWORK_STATE` 뿐이다. 기존 행의
"해당 앱" 칸에 이름만 더하면 된다.

### 6. 홈 JSON-LD `ItemList`

`index.html` · `ko/index.html` 의 `ListItem` 두 벌. 현재 7개 앱이 등재돼 있으므로 `position` 은
카드 순서에 맞춰 넣고, 뒤 항목의 번호가 밀리면 함께 고친다.

```json
{ "@type": "ListItem", "position": N, "name": "Dotori Roman Numerals",
  "url": "https://droidactor.github.io/apps/roman/" }
```

### 7. 역방향 링크 — **가장 빠뜨리기 쉬운 항목**

`<div class="also">` 가 있는 **기존 17개 파일 전부**에 `roman` 링크를 넣고, 새로 만드는 제품 페이지
두 장에는 나머지 앱 전부를 넣는다.

```
404.html · blog/index.html · ko/blog/index.html
apps/{bt-keyboard,bt-mouse,bt-ppt,lgtv,ssh-scout,wifi-scout,yt-downloader}/index.html
ko/apps/{같은 7개}/index.html
```

세는 법: `grep -rl '<div class="also">' --include="*.html" .`

### 8. 출시 확정 후 — `badge soon` → 스토어 배지

**곳 수를 외우지 말고 센다.** 앱마다 다르다.

```sh
grep -rn 'badge soon' --include="*.html" .                       # 바꿀 자리
grep -ro 'details?id=com.droidactor.lgtv' --include="*.html" . | wc -l   # 다 바꾼 뒤 비교할 기준
```

★ **`grep -c` 로 세지 말고 `-n` 으로 줄을 보고 세라.** `index.html` 에는 새 앱을 붙일 때 베껴 쓰라고
남긴 **HTML 주석 예시**에 `badge soon` 이 한 번 더 들어 있다. 개수만 세면 실제 배지 1곳이 2곳으로
잡힌다(2026-09-13 실측).

`lgtv` 는 블로그 글이 있어 **28곳**(홈 2 · `/apps/` 허브 2 · 제품 페이지 4 · 매뉴얼 2 · 블로그 16)이고,
`yt-downloader` 는 블로그·매뉴얼이 없어 **4곳**(홈 2 · 제품 페이지 2)이다. `roman` 은 아래 9 의
결정에 따라 달라진다.

홈 카드·제품 페이지 말고도 **매뉴얼·블로그에 배지가 있으면 거기도** 바꿔야 한다. 홈만 고치고 끝내면
매뉴얼에는 여전히 `Coming soon` 이 남는다.

### 9. 미결 — 매뉴얼·기술노트·블로그를 만들 것인가

`lgtv` 는 `manual/lgtv/`, `tech-notes/lgtv/`, `blog/control-lg-webos-tv-over-wifi/` 를 갖고 있고
`yt-downloader` 는 셋 다 없다. `roman` 은 조작이 단순해(두 칸 + 키패드) 매뉴얼이 꼭 필요하지는
않지만, **도움말 화면에 담은 내용**(일곱 글자 · 감산 6쌍 · 반복 한도 · 윗줄 ×1000 · 이 앱의 비표준
해석)은 검색 유입이 있을 만한 주제다. 만들기로 하면 8 의 배지 곳 수가 늘어난다.

## 끝내고 확인할 것

```sh
# 새 URL 이 200 인지
curl -o /dev/null -w '%{http_code}\n' https://droidactor.github.io/apps/roman/
curl -o /dev/null -w '%{http_code}\n' https://droidactor.github.io/ko/apps/roman/

# 남은 soon 배지가 없는지
grep -rc 'badge soon' --include="*.html" . | grep -v ':0'

# 코드 저장소 쪽 게이트
bash .claude/skills/play-release/scripts/play.sh check roman   # MyApps/Mobile 에서
```

`sitemap.xml` 주소 자체는 그대로이므로 Search Console 의 재수집을 기다린다 — **행 삭제·재제출은
사용자의 명시 지시가 있을 때만 한다**(`todo-update-google-search.md` §3.2). 그 지시로 9-12 에 1회
삭제·재제출을, 9-20 에 복사본 `sitemap-all.xml` 제출을 집행한 전례가 있고 **둘 다 이 문서의 기본
방침을 뒤집은 것이 아니라 그때마다 받은 예외다.**
