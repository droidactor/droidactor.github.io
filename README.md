# droidactor.github.io

Developer site for the droidactor Android apps — app listing, per-app product pages, support contact,
privacy policy, and the host for `app-ads.txt`.

`https://droidactor.github.io/` 로 게시되는 GitHub Pages 사이트다. Play Console · App Store Connect 에
**개발자 웹사이트**로 등록하는 주소이며, AdMob 의 `app-ads.txt` 크롤러가 읽는 도메인 루트도 여기다.

## 구조

영문(`/`)과 국문(`/ko/`)이 **별도 URL** 이다. 예전처럼 한 페이지에 두 언어를 넣고 CSS 로 감추지 않는다 —
`display:none` 뒤의 텍스트는 검색엔진이 비중을 크게 낮춰서 한글 검색에 잡히지 않았다.

```
/                       영문 홈 (앱 목록 · 지원 · 개인정보 처리방침 전문)
/ko/                    국문 홈 (같은 구성, 같은 앵커)
/bt-keyboard/           제품 페이지 — Dotori Bluetooth Keyboard      + /ko/bt-keyboard/
/bt-ppt/                제품 페이지 — Dotori Bluetooth PPT Remote    + /ko/bt-ppt/
/bt-mouse/              제품 페이지 — Dotori Bluetooth Mouse         + /ko/bt-mouse/
/wifi-scout/            제품 페이지 — Dotori WIFI Scout              + /ko/wifi-scout/
/ssh-scout/             제품 페이지 — Dotori SSH Scout               + /ko/ssh-scout/
/yt-downloader/         제품 페이지 — Dotori YouTube Downloader      + /ko/yt-downloader/
/lgtv/                  제품 페이지 — Dotori LG TV Remote            + /ko/lgtv/
/blog/                  글 목록 — Field notes                        + /ko/blog/ (현장 노트)
/blog/<slug>/           글 1편                                       + /ko/blog/<slug>/
/blog/_post-template.html  글 템플릿 — noindex · sitemap 제외. 페이지가 아니다
/assets/site.css        전 페이지 공용 스타일
/404.html               없는 주소 → 양 언어 홈으로 안내 (GitHub Pages 가 도메인 전역에 사용)
/robots.txt  /sitemap.xml
/app-ads.txt            AdMob 판매자 선언 (반드시 도메인 루트)
/.nojekyll              Jekyll 빌드 우회
/.gitignore             작업 메모(doit.txt)·리뷰 산출물이 공개 커밋에 딸려가지 않게 막는다
/googlec8773d84a9d25688.html   Search Console 소유권 확인 파일 — **지우면 소유권이 풀린다**
```

| 파일 | 역할 |
|---|---|
| `index.html` · `ko/index.html` | 앱 목록 + 지원 연락처 + **개인정보 처리방침 전문**. 처리방침 앵커의 정본이다 |
| `<앱>/index.html` | 제품 상세. 기능·요구사항·개인정보 요약을 담고, 처리방침 **전문은 홈 앵커로 링크**한다(중복 금지) |
| `blog/index.html` · `ko/blog/index.html` | 글 목록. **손으로 관리한다** — 이 리포에 생성기는 없다. 열 편쯤 넘어 손이 아프면 그때가 도입 신호다 |
| `blog/_post-template.html` | 글 템플릿. slug·경로·JSON-LD·CTA 규약을 머리주석에 담고 있으며 **글 추가 절차의 정본**이다 |
| `assets/site.css` | 전 페이지 공용. 외부 CDN·폰트·스크립트 없음(자기완결) |
| `sitemap.xml` | 홈·제품 16개 URL + `xhtml:link` hreflang. 페이지를 추가하면 여기도 넣는다. 블로그 URL도 같은 언어 쌍 규칙을 따른다 |
| `robots.txt` | 전체 허용 + sitemap 위치 |
| `404.html` | 루트 절대경로만 쓴다 — 어느 깊이의 주소에서든 서빙되기 때문이다. `noindex` |
| `app-ads.txt` | **AdMob 콘솔이 생성한 줄을 그대로** 넣는다 — 손으로 만들지 않는다 |
| `.nojekyll` | GitHub Pages 의 Jekyll 빌드 우회. 파일이 손대지 않은 채 그대로 서빙되게 한다 |

`app-ads.txt` 는 **도메인 루트에 있어야 한다.** 그래서 이 리포 이름이 `droidactor.github.io` 여야 하고
(User site → 루트 서빙), 이름이 다르면 `/<리포명>/app-ads.txt` 로 밀려 검증이 실패한다.

## 등록하는 URL

| 용도 | URL |
|---|---|
| 개발자 웹사이트 | `https://droidactor.github.io/` |
| 개인정보 처리방침 (영문) | `https://droidactor.github.io/#privacy` |
| 개인정보 처리방침 (국문) | `https://droidactor.github.io/ko/#privacy` |
| 앱별 처리방침 | `#privacy-<app key>` — `keyboard` · `ppt` · `mouse` · `wifi` · `ssh` · `ytdl` · `lgtv` (`apps.tsv` 의 key 와 같다) |
| app-ads.txt 검증 | `https://droidactor.github.io/app-ads.txt` |

**`#privacy-*` 앵커 이름은 바꾸지 않는다.** 스토어 리스팅에 이미 등록된 주소다. 국문 처리방침이 필요하면
같은 앵커를 `/ko/` 아래에서 쓴다(`/ko/#privacy-keyboard`). Play Console 은 스토어 등록정보 언어별로
처리방침 URL 을 따로 넣을 수 있다.

크롤러의 출발점은 **스토어 앱 페이지의 "개발자 웹사이트" 필드**다. 그 칸이 비어 있으면 파일이 정상이어도
검증되지 않는다.

## 검색 노출

사이트가 새로 만들어졌고(2026-07-28) 외부 링크가 없어서 구글이 발견하지 못하는 상태였다. 아래를 갖췄다.

- `robots.txt` · `sitemap.xml`
- 페이지마다 `canonical`, `og:*`, `hreflang`(en / ko / x-default 상호 참조), JSON-LD
  (홈 = `WebSite`+`Organization`+`ItemList`, 제품 = `SoftwareApplication`)
- 색인 단위를 1개에서 **16개**로 늘린 홈·제품별 URL
- `/blog/` · `/ko/blog/` — 제품 페이지는 "이 앱은 무엇인가"만 답한다. 앱을 아직 모르는 사람이
  검색하는 것은 **문제**("PLC IP 주소 찾기", "TV 한글 입력")이고, 그 검색어를 받는 자리가 블로그다.
  글은 자기 도메인에 먼저 올리고, 외부 플랫폼에는 canonical 을 건 재배포만 한다

**남은 것은 사람이 해야 한다 — Google Search Console 등록.** 이게 없으면 색인까지 몇 주가 걸린다.

1. <https://search.google.com/search-console> 에서 속성 추가 → **URL 접두어** 로
   `https://droidactor.github.io/` 입력 (도메인 속성은 DNS 를 요구하므로 `github.io` 에서는 불가)
2. 소유권 확인은 **HTML 파일 업로드** 방식이 이 리포에 맞는다. 현재 `googlec8773d84a9d25688.html` 이
   루트에 있다. **이 파일은 지우지 않는다** — 지우면 소유권이 풀리고 색인 요청 권한도 사라진다.
   확인 파일을 다시 발급받으면 옛 파일은 지우지 말고 새 파일을 함께 둔다(둘 다 유효하다).
3. 좌측 **Sitemaps** 에 `sitemap.xml` 제출
4. **URL 검사**에 `https://droidactor.github.io/` 를 넣고 **색인 생성 요청**. 주요 제품 페이지도 같은 방식으로
   한 번씩 요청한다(하루 할당량이 있어 16개를 한 번에 다 넣지는 못한다)

가장 강한 유입 경로는 여전히 **Play Store 앱 페이지의 "개발자 웹사이트" 링크**다. 앱이 출시되면
그 칸을 반드시 채운다.

## 남은 일

- [x] Google Search Console 등록 + 소유권 확인 (2026-08-02, URL 접두어 속성 + HTML 파일 방식)
- [x] **sitemap 재제출 (2026-08-06).** 최초 제출분(2026-08-02)이 `가져올 수 없음` 으로 굳어 있었다 —
      발견된 페이지 0, "마지막으로 읽은 날짜" 비어 있음. `sitemap.xml` 커밋(`efee63e`)과 제출이 같은
      날이라 GitHub Pages 배포 전에 크롤이 시도돼 실패했고, 그 뒤 재시도가 성공한 기록이 없었다.
      파일 자체는 정상이었다(2026-08-06 실측 `HTTP 200` · `application/xml` · 22 URL). 같은 URL 을
      다시 제출해 "사이트맵이 제출됨" 을 받았다. **기존 행은 지우지 않았다** — 같은 URL 재제출이면
      항목이 갱신되고, 이력이 남아야 재크롤 성공 시점을 비교할 수 있다.
      (이 항목이 적은 "배포 전 크롤" 원인 진단은 2026-08-08 에 반증됐다 — 바로 아래 항목.)
- [x] **`가져올 수 없음` 원인 규명 (2026-08-08).** 서버·파일 결함이 아니라 **크롤 미도달**이다.
      URL 검사의 실시간 테스트에서 Googlebot 이 `sitemap.xml` 을 그 자리에서 가져왔는데
      (11:34, "페이지 색인을 생성할 수 있음"), 예약 크롤 쪽은 "최근 크롤링: 해당사항 없음",
      "감지된 참조 사이트맵이 없습니다" 였다 — **가져오려다 실패한 것이 아니라 가지러 온 적이 없다.**
      사이트맵 유형이 계속 `알 수 없음` 인 것도 같은 뜻이다(한 번이라도 파싱했다면 `사이트맵` 으로 바뀐다).
      페이지 색인 생성 보고서도 색인됨 `1` · 색인 안 됨 `0` — 22개 URL 중 루트 하나만 알려져 있었다.
      서버는 실측 정상(`HTTP 200` · `application/xml` · BOM 없음 · 유효 XML · 22 URL · `robots.txt` 200 ·
      http→https 301 · A/AAAA 정상). `droidactor@gmail.com` 과 `hugemail2me@gmail.com` 두 계정에서
      같은 속성·같은 상태였으므로 계정 문제도 아니다. 배경은 등록 6일차 신규 `github.io` 서브도메인이라
      크롤 예산이 0 에서 시작한다는 것 — `github.io` 는 Public Suffix List 등재라 도메인 신뢰도를
      상속받지 못한다. **그래서 재제출을 반복해도 상태는 바뀌지 않는다. 크롤을 부르는 것이 유일한 수단이다.**
- [x] **색인 생성 요청 10건 (2026-08-08).** URL 검사에 하나씩 넣어 요청했고 전부
      "URL이 우선순위 크롤링 대기열에 추가되었습니다" 를 받았다:
      `/ko/` `/blog/` `/ko/blog/` `/bt-keyboard/` `/bt-mouse/` `/lgtv/` `/bt-ppt/` `/wifi-scout/`
      `/ssh-scout/` `/yt-downloader/`. 루트 `/` 는 이미 색인돼 있어 제외했다.
      **효과 확인 (2026-08-10 실측): 이 전략은 작동한다.** 알려진 URL 이 `1` → `9` 로 늘었다.
      요청한 10건 중 8건에 실제로 크롤이 왔다(전부 8-08 크롤) — 색인됨 `6`
      (`/` `/bt-keyboard/` `/bt-mouse/` `/lgtv/` `/wifi-scout/` `/ssh-scout/`), 크롤됐지만 색인 대기 `3`
      (`/ko/` `/blog/` `/ko/blog/`, 사유 "크롤링됨 - 현재 색인이 생성되지 않음" · 유효성 검사 "시작되지 않음").
      아직 크롤이 닿지 않은 요청분은 `/bt-ppt/` `/yt-downloader/` 둘이다.
      색인 대기 3건이 하필 한국어 홈과 블로그 허브인 것은 우연이 아니다 — 허브 2개는 발췌 목록뿐이라
      본문이 제품 페이지의 1/3 이고(9.4KB · 10.2KB 대 28~30KB) 링크 대상인 블로그 글 16편이 아직
      한 편도 크롤되지 않아 목록으로서 실체가 없다. `/blog/` 는 홈에서 들어오는 내부 링크도 1회뿐이다
      (제품 페이지는 각 3회). **이 3건은 결함이 아니라 판정 대기이므로 손대지 않고 기다린다.**
- [x] **색인 생성 요청 10건 (2026-08-10).** 블로그 글 5종을 **en/ko 짝으로** 넣었다. 전부
      "URL이 우선순위 크롤링 대기열에 추가되었습니다" 를 받았고 할당량 경고는 없었다:
      `type-korean-over-bluetooth-hid` · `use-android-phone-as-powerpoint-remote` ·
      `use-android-phone-as-bluetooth-mouse` · `find-devices-on-wifi-from-android` ·
      `find-and-connect-to-ssh-hosts-from-android` (각각 `/blog/<slug>/` 와 `/ko/blog/<slug>/`).
      **짝으로 넣은 이유** — 양쪽 허브가 동시에 실체를 갖고 hreflang 쌍이 한 번에 확정된다.
      한쪽 언어만 몰아넣으면 반대쪽 허브는 다음 차례까지 계속 빈 목록으로 남는다.
- [ ] **남은 13개 URL 색인 요청.** 하루 할당량이 10건 안팎이라 다음 날로 넘어간다.
      블로그 글 3종 6개(`control-lg-webos-tv-over-wifi` · `find-ls-plc-ip-address` ·
      `identify-industrial-devices-by-port` 의 en/ko 짝)를 먼저 넣어 블로그를 끝내고,
      그 다음 한국어 제품 7개(`/ko/bt-keyboard/` `/ko/bt-ppt/` `/ko/bt-mouse/` `/ko/wifi-scout/`
      `/ko/ssh-scout/` `/ko/yt-downloader/` `/ko/lgtv/`).
      아직 크롤이 닿지 않은 `/bt-ppt/` `/yt-downloader/` 는 8-08 에 이미 요청했으므로 다시 넣지 않는다
      (대화상자가 명시한다 — "페이지를 여러 번 제출해도 대기열 위치나 우선순위가 변경되지 않습니다").
      (원래 "남은 11개" 로 적혀 있었으나 그것은 sitemap 이 22 URL 이던 시점 기준이다. 8-08 의
      블로그 6종 추가로 34 URL 이 됐고, 그중 Google 이 아는 것은 9개다 — 2026-08-10 실측.)
- [ ] sitemap 상태가 `성공` · 발견된 페이지 `34` 로 바뀌는지 확인. 위 색인 요청으로 사이트 크롤이
      살아나면 사이트맵 페치도 따라온다. **사이트맵 행을 지우고 다시 제출하지 않는다** — 이력만 잃고
      크롤 우선순위는 그대로다.
      **2026-08-10 에 이 규칙을 어기고 삭제 후 재제출을 실행했다** — 에이전트가 이 항목과 위 8-08
      진단을 읽지 않은 채 "고착된 실패 레코드를 비우는 유일한 경로" 라고 잘못 권고했고 그대로 실행됐다.
      결과는 이 항목이 예측한 그대로다: "마지막으로 읽은 날짜" 만 `26. 8. 6.` → `26. 8. 10.` 으로
      바뀌었을 뿐 상태 `사이트맵을 읽을 수 없음` · 유형 `알 수 없음` · 발견된 페이지 `0` 은 그대로였다.
      8-06 이력만 잃었다. **재제출·삭제재제출은 이것으로 두 번 반증됐다. 다시 시도하지 않는다.**
      같은 날 라이브 테스트도 다시 돌렸는데 8-08 과 동일하게 통과했다(`오전 7:11`,
      "URL을 Google에 등록할 수 있음") — 서버·파일은 여전히 결백하고 문제는 예약 크롤 미도달뿐이다.
- [ ] **한국 스토어 등록정보의 개인정보 처리방침 URL 을 `/ko/#privacy-<key>` 로 교체.**
      언어를 자동 전환하던 JS 를 없애고 `/` 를 영문 고정으로 바꿨으므로, 지금 등록된 `/#privacy-*` 는
      한국 사용자에게 영문 처리방침만 보여준다. 앱을 심사에 넣기 전에 처리한다.
- [ ] 앱이 출시되는 대로 `badge soon` 을 스토어 링크로 교체 — 홈 2곳(`/`, `/ko/`)과 제품 페이지 2곳,
      합쳐서 앱당 4곳이다.
- [ ] 제품 페이지에 스크린샷 추가(현재는 텍스트만). 이미지를 넣으면 `og:image` 도 함께 채운다.

지원·개인정보 문의 주소는 `droidactor@gmail.com` 이다(홈의 Support 섹션과 §8).
개인정보 처리방침의 연락처는 Play 정책상 필수 항목이므로 비워두지 않는다.

## 고칠 때

- **앱을 추가하면** 다음을 한 묶음으로 처리한다. 하나라도 빠지면 링크가 깨지거나 색인에서 누락된다.
  1. 홈 카드 2개 — `index.html`, `ko/index.html` 의 `<article class="card">`
  2. 처리방침 앱별 항목 2개 — 같은 두 파일의 `<div class="policy" id="privacy-…">`
  3. 제품 페이지 2개 — `<앱>/index.html`, `ko/<앱>/index.html`
  4. `sitemap.xml` 에 URL 2개 (hreflang 3줄씩)
  5. 새 권한이 생기면 처리방침 §4 권한 표에 행 추가 (두 언어 모두). 기존 권한을 쓰는 앱이라도
     그 행의 "해당 앱" 칸에 이름을 더한다
  6. 홈 JSON-LD `ItemList` 에 `ListItem` 2개 (`index.html` · `ko/index.html`, position 은 카드 순서)
  7. **역방향 링크** — 기존 모든 페이지의 `<div class="also">` 에 새 앱을 넣는다. 제품 12 + 블로그 목록 2
     + `404.html` 이고, 새 제품 페이지 쪽에는 나머지 앱 전부를 넣는다. 여기를 빠뜨리면 홈 카드 외에는
     새 앱으로 들어가는 내부 링크가 없어 크롤러가 한 경로로만 본다(bt-mouse 를 붙일 때 실제로 빠뜨렸다)
  8. 손댄 페이지의 `<lastmod>` 갱신
- **블로그 글을 추가하면** 다섯 가지를 한 묶음으로 처리한다. 자리표시자와 세부 규약의 정본은
  `blog/_post-template.html` 머리주석이다.
  1. `blog/<slug>/index.html`(`lang="en"`) · `ko/blog/<slug>/index.html`(`lang="ko"`) —
     **slug 는 두 언어가 같은 문자열이다.** 그래야 hreflang 쌍이 기계적으로 맞는다
  2. 두 목록 페이지에 `<li>` 추가 — `blog/index.html`, `ko/blog/index.html`
  3. `sitemap.xml` 에 글 URL 2개. **첫 글이라면 주석 처리된 블로그 목록 쌍도 이때 함께 푼다**
  4. 손댄 페이지의 `<lastmod>` 갱신
  5. 글 끝 CTA 는 **앱 하나만** 가리킨다. 다섯 개를 나열하면 아무 데도 가지 않는다
- **전역 네비게이션 항목이 늘면**(블로그처럼 새 섹션이 생기면) 푸터가 있는 **모든 페이지**를 고친다 —
  홈 2 + 제품 14 + `404.html` + 블로그 목록 2. 홈만 고치면 나머지 페이지에서 그 섹션에 닿을 길이 없고,
  크롤러도 홈 한 곳에서만 링크를 본다. 블로그를 붙일 때 실제로 여기서 한 번 빠뜨렸다.
- **개인정보 처리방침을 고치면** 섹션 머리의 "최종 갱신 / Effective date" 날짜를 함께 고친다. **두 언어 모두다.**
- **제품 페이지에 처리방침 전문을 복사하지 않는다.** 요약 + 홈 앵커 링크만 둔다. 두 벌이 되면 반드시 어긋난다.
- 권한 설명은 추측하지 않고 각 앱의 `AndroidManifest.xml` 을 근거로 쓴다. 위치 권한 없음,
  `NEARBY_WIFI_DEVICES` 의 `neverForLocation` 처럼 심사에서 문제되는 항목은 매니페스트가 근거다.
- 앱 목록·패키지명·출시 상태·minSdk 의 정본은 이 리포가 아니라 `MyApps/Mobile/apps-map.md` 다.
- 스타일을 고칠 일이 있으면 `assets/site.css` 한 곳만 고친다. 페이지에 `<style>` 을 다시 넣지 않는다.

## 확인

내부 링크가 `/bt-keyboard/` 같은 **절대경로**라 `file://` 로 열면 링크가 동작하지 않는다. 로컬 확인은
정적 서버로 한다.

```sh
python -m http.server 8000     # 그리고 http://localhost:8000/ 을 연다
```

게시 설정은 `Settings → Pages → Source = Deploy from a branch`, `main` / `/ (root)`.

AdMob 콘솔의 app-ads.txt 상태가 "확인됨" 으로 바뀌는 데 하루 이상 걸린다. 반영이 늦다고 파일을 계속
고치지 말고, `https://droidactor.github.io/app-ads.txt` 가 브라우저에 그대로 보이는지만 확인한다.
