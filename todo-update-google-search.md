# Google Search Console 운영 문서 — droidactor.github.io

마지막 갱신 2026-11-20 13:26 새 배포 `9f52cd3` 10건 접수(미접수 0·보류 1) · 보고서 기준일 11-16 재집계(색인 196, lgtv `다른 표준` 해소) · 00:00 daily 재대조 · 11-18 vault 한·영 접수 · 11-16 실적 확인 · 11-14 전면 축약

이 문서에는 **다음 작업에 필요한 것만** 담는다. 지난 회차 기록·판독 근거·철회된 해석은 git 이력에 있다.

- 11-14까지의 전체본(회차별 §2.7~§2.26, 일별 §10, CDP 절차 상세): `git show 9214b90:todo-update-google-search.md`
- 08-14~09-17 로그: `git show cc532b1:todo-update-google-search.md`
- 회차별 원본(사전 점검·URL 검사·접수 대화상자): 커밋 제외 폴더 `.review/gsc-*/`

**갱신 규칙** — 회차가 끝나면 §1 상태, §2.1 남은 목록, §4 원장만 고친다. 회차 경과는 문서에 쌓지 않고 커밋 메시지와 `.review/`에 남긴다.

다른 문서가 가리키는 옛 절 번호: 옛 §3.2(하지 않는 것) → §5.2, 옛 §7.4(sitemap 복사본 실험) → §7.1(상세는 `9214b90`).

---

## 1. 현재 상태 (2026-11-20)

| 항목 | 값 |
|---|---|
| 속성 | `https://droidactor.github.io/` (URL 접두어). 새 속성은 만들지 않는다 |
| live sitemap | **246개**. 마지막으로 대조한 배포 커밋 `9f52cd3`(11-20 13:05 KST 배포, 13:09 대조, fetch 후 HEAD = origin/main). `c6d1eb4` 이후 새 `<loc>` 10개(제품 글 4쌍·Herdr 기술 글 쌍)·삭제 0. `fbd051c`는 홈 처리방침 문구만 바꿨다. 로컬 `sitemap.xml`·`sitemap-all.xml`과 live 두 파일이 바이트까지 같다. 다른 세션 기록(`**/todo-google-search.md`·`**/play/README.md`)에 새 URL 10개의 접수 기록 없음 |
| Sitemaps 보고서 | 두 행 모두 `가져올 수 없음` · 발견 0 · 마지막 읽은 날짜 없음 (11-20 재확인, §7.1) |
| Page indexing 보고서 | 기준일 **11-16**(11-20 13:25 재집계), 색인 **196** · 미색인 **31** (크롤링됨 31 · 다른 표준 0) |
| 최근 접수 URL 검사 | **11-20 13:14~13:23 KST** 요청 직전 검사: 새 URL 10개 모두 `아직 알려지지 않은 URL`. 11-18 vault 홍보글(영문 색인·국문 크롤 후 미색인)은 그 뒤 재검사하지 않았다. 보고서 합계에 합산하지 않는다 |
| Google 실적 | 11-16 재판독 완료. 최근 28일 `10-18~11-14`, 페이지 표 136행 합계 **77클릭·2,582노출**. 헤드라인은 76클릭·약 2.53천 노출로 기준을 섞지 않는다 |
| 네이버 서치어드바이저 | **11-17 로그인 계정 일치 확인·등록 사이트 0개**. 기존 사이트 요약에 직접 접근해도 `접근권한이 없습니다`. 8-10 등록 당시와 동일 계정인지는 기록 부족으로 미확정이며 sitemap 처리 결과도 미확인 |
| 접수 원장 | **230개** (§4). 11-20 새 배포 10건 접수 |
| 남은 요청 | 미접수 **0개** + 보류 1개 (§2.1) |
| 마지막 제출 시도 | **11-20 13:23:48 KST** 시도 → **13:24:07 접수** (`/ko/blog/products/korea-subway-regions/`). 24시간 창 안 시도 10건(13:14:34~13:23:48)이라 새 후보의 다음 회차는 **11-21 13:29 KST 이후** |

11-13 → 11-16 보고서 재대조: 색인 196개 전수 중 live sitemap 안 **186개**, 밖 10개(같은 옛 스텁), sitemap 246개 중 색인 목록에 없는 URL **60개**(오늘 낸 10개 포함)다. 직전 목록 대비 색인 진입 14개·이탈 1개. 진입은 `(ko/)apps/{daejeonmetro,lgtv,light,macropad,qr}/` · `/apps/counter/` · `/ko/apps/vault/` · `(ko/)blog/products/flashlight-camera-app/`, 이탈은 `/ko/manual/lgtv/`(크롤링됨으로)다. 크롤링됨은 진입 4개(`(ko/)blog/techs/everything-file-search-guide/` · `/ko/apps/counter/` · `/ko/manual/lgtv/`)·이탈 1개(`/ko/apps/vault/`, 색인으로)다. **lgtv 새 URL 한·영이 11-16 크롤 후 색인돼 `다른 표준`이 0이 됐다**(§7.2). 홈·국문 Wi-Fi는 여전히 크롤링됨이다. 드릴다운에는 기준일 뒤인 11-17 크롤도 섞여 있으므로 보고서 수치와 실시간 검사 결과는 구분한다. 드릴다운 셀 끝에 아이콘 글꼴 문자(U+E000~F8FF)가 붙어 나오므로 대조 전에 지운다. 원본·전수 목록·차이는 `.review/gsc-20261120/`에 있다.

실적 비교(각 28일, **페이지 표 전수 합**): 옛·새 URL은 §5.1의 7개 제품 한·영 쌍만 센다. 첫 구간은 9-17 기록과 이번 재조회 결과가 일치한다.

| 구간 | 표 행 수 | 전체 클릭 | 전체 노출 | 옛 URL 노출 | 새 `/apps/` URL 노출 |
|---|---|---|---|---|---|
| 08-18~09-14 | 50 | 28 | 932 | 89 | 111 |
| 09-20~10-17 | 99 | 40 | 2,107 | 45 | 96 |
| 10-18~11-14 | 136 | 77 | 2,582 | 41 | 207 |

직전 28일 대비 옛 URL 노출은 약 9% 감소했고 새 URL은 약 116% 늘었다. 새 URL 증가분은 주로 bt-keyboard(44→158)다. lgtv는 옛 URL 15→11·새 URL 0으로 미해결이며, 옛 주소 전체가 새 주소로 교체된 것은 아니다. 그 사이 **기술 글 28 URL(09-17~19 세 회차) 요청**, 경제 글·신규 제품·다국어 글 배포와 후속 요청이 함께 진행돼 변화를 개별 조치의 효과로 단정하지 않는다. 실적 원본과 네이버 목록 확인 근거는 `.review/search-reports-20261116/`에 있다.

---

## 2. 할 일

### 2.1 남은 요청 — 대기 0건·보류 1건

| 순서 | URL |
|---|---|
| 보류 | `/hi/blog/` — 11-04 제출 오류 뒤 접수 여부를 확인하지 못했다. 11-18 19:05 KST에도 `아직 알려지지 않은 URL`. **사용자 결정 없이 재요청하지 않는다** |

현재 제출할 신규 URL은 없다. 11-20 배포 `9f52cd3`의 새 URL 10개(`(ko/)blog/products/{qr-barcode-scanner-app,pc-youtube-remote,review-walking-route-details,korea-subway-regions}/` · `(ko/)blog/techs/herdr-in-wezterm/`)는 사전 점검 통과·요청 직전 검사(모두 `아직 알려지지 않은 URL`) 뒤 13:15:09~13:24:07 KST에 모두 접수됐고, 대화상자를 닫은 뒤에도 오류가 없었다. 새 배포로 생긴 URL은 이 표 끝에 더한다. 사전 점검·URL 검사·접수 근거는 `.review/gsc-20261120/`에 있다.

### 2.2 회차 절차 (daily 재대조 포함)

1. **새 배포 확인** — `git fetch` 후 HEAD·`origin/main`을 본다. 직전 기록 이후 커밋은 `git log --stat`으로 파일 목록을 끝까지 읽는다(§6).
2. **sitemap 대조** — 로컬 두 파일과 live 두 파일이 바이트까지 같은지 본다(어긋나면 §6). 후보는 `sitemap.xml` 기준으로, 새 `<loc>`가 새 후보다. 기존 페이지의 본문·`lastmod`만 바뀐 것은 재요청 사유가 아니다.
3. **다른 세션 기록 확인** — 사이트 `README.md`, `F:/Git/kwak/mobile/**/todo-google-search.md`, `**/apps/*/play/README.md`에서 접수 기록을 찾아 §4에 옮긴다.
4. **사전 점검** — 후보마다 HTTP 200 · 최종 URL 동일 · self canonical · `noindex`/`X-Robots-Tag` 없음 · live sitemap 포함 · hreflang 상호 참조. 출시 전(`Coming soon`) 페이지도 대상이다(yt-downloader·pedometer 선례). 11-14 스크립트 `.review/gsc-20261114/preflight.mjs`를 고쳐 쓴다(커밋 제외 파일이라 없으면 같은 항목으로 다시 짠다).
5. **시작 시각** — **KST 09:00 이후**, 그리고 §1의 마지막 제출 시도(거절 포함, 두 계정 합산) + 24시간 + 여유 5분 뒤. **00:00 daily 재대조는 대조와 목록 갱신만 하고 제출하지 않는다.**
6. **제출** — §3 절차로 Aside에서만 한다. 접수 즉시 기록하고, 원본은 회차 중에도 저장소 `.review/gsc-YYYYMMDD/`로 복사한다.
7. **문서 갱신** — §1·§2.1·§4.
8. **보고서 재집계** — 기준일이 §1의 기준일을 넘었을 때만 한다(§2.4).

### 2.3 관찰 중 — 재요청하지 않는다

| 대상 | 상태 |
|---|---|
| `/ko/blog/techs/wezterm-shortcut-menu/` | 11-13 요청, 같은 날 11:55:08 크롤 후 미색인 |
| `/hi/blog/products/seoul-subway-map-app/` | 11-12 요청, 크롤 후 미색인 |
| `/` · `/ko/apps/wifi-scout/` | 11-09 보고서에서 색인 → `크롤링됨`으로 빠졌고 11-13·11-16 보고서에서도 그대로다. 원인 미확인. 사이트는 그대로 둔다. `/`는 요청 이력이 없지만 **요청하지 않는다** — 필요하면 사용자 결정 |
| 오래 미발견(11-16 보고서에도 없음) | `(ko/)manual/bt-keyboard/`(08-17) · `(ko/)tech-notes/{bt-ppt,bt-mouse,wifi-scout,ssh-scout}/`(08-31) · `(ko/)apps/yt-downloader/`(09-05) · `(ko/)blog/use-android-phone-as-{bluetooth-mouse,powerpoint-remote}/`(09-10) · `(ko/)blog/products/learn-korean-numbers/`(10-30) |
| 11-16 보고서에서 새로 크롤링됨 | `(ko/)blog/techs/everything-file-search-guide/`(11-17 요청·크롤) · `/ko/apps/counter/`(11-15 요청, 영문은 색인) · `/ko/manual/lgtv/`(색인에서 빠짐, 11-17 크롤) |
| 그 밖의 크롤링됨 | 허브 `/apps/`·`/ko/apps/`·`/manual/` · `/ko/blog/` · `/ko/tech-notes/bt-keyboard/`와 상세 4편 · `/ko/tech-notes/receipt/` · 국문 기술 글 6편 · `/blog/techs/what-to-delegate-to-ai/` · 경제 트렌딩 4편 · `/sitemap.xml` · 옛 스텁 `/ko/bt-ppt/`. 전수 목록은 `.review/gsc-20261120/crawled-rows.json` |

국문만 미색인이고 영문 짝은 색인된 묶음이 많다. 원인은 확인되지 않았다.

### 2.4 판독 규칙

- **보고서는 기준일 스냅샷이다.** 요청 결과는 실시간 URL 검사로 보고, 두 값을 합산하지 않는다. 드릴다운 표는 기준일보다 최신 값을 담을 수 있다.
- **재집계는 기준일이 바뀌었을 때만, 하루 한 번 이하로 한다.** 색인 목록 전수(§3.3)를 live sitemap과 대조해 색인 ∩ sitemap, 미색인의 들어오고 나간 URL을 적는다.
- **Sitemaps 상태는 주 단위로 본다.** 판별점은 §7.1.
- 재판독 때 그 사이 움직인 변수(요청 묶음·새 배포)를 함께 적는다.
- 요청에서 색인까지 걸리는 시간은 편차가 크다(몇 분 뒤 크롤되는 것부터 몇 주째 미발견까지). "며칠이면 색인된다"로 일반화하지 않는다.

### 2.5 사용자 결정 대기

| # | 사안 | 현재 |
|---|---|---|
| 1 | `/hi/blog/` 재요청 | 보류 (§2.1) |
| 2 | 오래 미발견인 URL 18개(§2.3, 8-31 tech-notes 8개 포함) 재요청 | 재요청하지 않음 |
| 3 | 형식이 다른 최소 sitemap(예: `sitemap.txt`)을 새 행으로 제출하는 실험 | 미실행 (§7.1) |
| 4 | `/blog/techs/`·`/ko/blog/techs/`가 live 404 | 설계상 갈래 index가 없다. 후보: 그대로 / `meta refresh`로 `/blog/` / 목록 페이지 신설 |
| 5 | `(ko/)manual/roman/`에 `manual-meta`(앱 버전 점검 문구) 추가 | 점검하지 않아 넣지 않았다 |
| 6 | sitemap 이미지 확장(`image:image`) | 넣지 않는다. sitemap 처리부터 성공해야 의미가 있다 |
| 7 | `datePublished` 규약(배포일)과 기술 글 28편·경제 트렌딩 11편(초고일)의 차이 | 09-17 결정 "그대로 둔다". 다음 글을 낼 때 규약이나 배포본 중 하나로 맞춘다 |
| 8 | 홍보글 `(ko/)blog/products/id-photo-app/`에 AI 고지 없음 | `blogger` 원고 쌍에서 나와 네이버·Medium에도 나간 글이라 따로 정한다 |

실적 보고서 재판독은 **11-16 완료**(§1). 네이버는 **11-17 네이버 홈과 서치어드바이저의 로그인 계정이 일치함**을 확인했다. 등록 사이트는 0개이고 기존 사이트 요약 직접 조회도 주소 끝 `/` 유무와 관계없이 권한이 거부된다. 8-10 등록·소유확인·sitemap 제출 완료는 `687f2cd`·`dda70f7` 기록으로 확인되지만 당시 아이디가 없어 동일 계정인지는 확정하지 못했다. [공식 안내](https://help.naver.com/service/30010/bookmark/17591?lang=ko&osType=PC)는 소유확인을 1년마다 갱신한다고 하므로 통상적인 기간 만료로 단정할 근거도 없다. 사이트가 보이지 않는 원인과 기존 등록 권한을 확인한 뒤 보고서를 읽는다. 이번 확인 근거는 `.review/naver-account-20261117/`에 있다.

---

## 3. 색인 생성 요청

### 3.1 규칙

- **Aside(실제 브라우저)로만 제출한다.** headless CDP로 낸 요청은 코드 7·일반 제출 오류로 거절된다(11-12 확정). Aside를 쓸 수 없으면 미루고 사용자에게 알린다.
- **같은 URL은 다시 요청하지 않는다.** 판정은 §4 원장으로만, 언어 접두사까지 포함한 전체 URL로 한다. `/blog/techs/`와 `/ko/blog/techs/`는 슬러그가 같으니 슬러그로 찾지 않는다. 재요청은 효과도 없다(GSC가 대기열 순위가 바뀌지 않는다고 명시).
- **KST 09:00 이후에만 제출한다.** 이 제한의 해제는 그 회차에 한해 사용자 승인으로만 한다.
- **할당량** — 속성 단위로 보이고(추정), 24시간이 굴러가는 창이다. 날짜가 바뀌어도 초기화되지 않는다. 24시간 안 시도 11~12건 뒤 다음 건이 `할당량 초과`로 거절된 사례가 여러 번 있다.
- **하루 상한은 접수 10개다.** 다음 회차 시작 시각은 거절된 시도까지 포함한 마지막 시도로 계산하고, 두 소유 계정을 합친다(§2.2 5번). 회차가 거절로 끝나면 그 시각을 §1에 적는다.
- **`할당량 초과`나 일반 제출 오류가 나오면 그날은 바로 멈춘다.**
- 직전 결과 뒤 **25초 이상** 두고 다음 건을 낸다.
- 요청 직전 검사에서 이미 `URL이 Google에 등록되어 있음`이면 요청하지 않는다.
- 옛 URL(§5.1)에는 요청하지 않는다.
- **성공 판정은 두 단계다.** ① `색인 생성 요청됨` + `우선순위 크롤링 대기열` 문구 ② 그 대화상자를 닫은 뒤 `할당량` 문구가 뒤따르지 않음. 결과 카드의 `✓ 색인 생성 요청됨`은 거절돼도 남으므로 근거가 아니다.

### 3.2 Aside 절차

- 시작은 전역 지침대로 `session-desktop.ps1 aside`를 쓰고, 조작은 `mcp__aside__repl`(세션 유지)로 한다. MCP가 없으면 대화형 `aside repl`(PTY)로 한다. 1회용 호출은 상태와 탭 소유가 끊긴다.
- **계정** — `/u/0/` = `droidactor@gmail.com`. 매 회차 snapshot 트리에 이 주소가 있는지 확인한다. 두 번째 소유자 계정의 이메일은 공개 저장소라 적지 않는다.
- 개요 URL: `https://search.google.com/u/0/search-console/index?resource_id=https%3A%2F%2Fdroidactor.github.io%2F&hl=ko`
- 함수를 `globalThis`에 정의해 재사용한다. 호출 제한이 120초라 **한 호출에 한 건**씩 낸다(11-14 실측, 간격 대기 포함 건당 약 50초).

| 단계 | 하는 일 | 실패 시 |
|---|---|---|
| 0 | 개요로 `goto`. 계정 확인. 검사창이 안 보이면 banner의 `검색` 버튼 ref를 눌러 펼친다 | 중단 |
| 1 | 검사창 `click` → `fill(url)` → `inputValue()`가 url과 같은지 확인 | 입력 게이트 실패 — 누르지 않는다 |
| 2 | `press('Enter')` → snapshot에 `- text: "<url>"`이 뜰 때까지 3초 간격 폴링 | 착지 게이트 실패 — 누르지 않는다 |
| 3 | 요청 전 상태를 기록. 이미 색인이면 건너뛴다 | — |
| 4 | 같은 트리에서 요청 버튼 ref를 정규식으로 뽑아 클릭. 시도 기록을 먼저 저장 | 버튼 없음 → 중단 |
| 5 | `우선순위 크롤링 대기열`이 뜰 때까지 3초 × 50회(150초). `할당량`이 보이면 그날 끝 | 끝까지 결과 문구가 없으면 접수 불명으로 기록하고 그날 끝. 재요청하지 않는다(`/hi/blog/` 선례) |
| 6 | **접수 시각을 바로 기록**(할당량 재확인보다 먼저) | — |
| 7 | `닫기` ref 클릭 → 4초 → 다시 snapshot해 `할당량`·`문제가 발생했습니다`가 없는지 확인 | 그날 끝 |

```
검사창   : input[role="combobox"][aria-label*="모든 URL 검사"]
요청 버튼: /- button "색인 생성 요청[^"]*" \[ref=(e\d+)\]/
닫기 버튼: /- button "닫기" \[ref=(e\d+)\]/
```

**함정**

- 요청을 마치면 GSC가 검사창을 접는다. 매 건 개요로 `goto`해서 시작한다.
- 버튼은 텍스트 selector로 잡히지 않는다. ref는 snapshot마다 바뀌므로 착지한 그 트리에서 뽑아 바로 쓴다.
- 판정은 `snapshot(page)`의 `.tree`로 한다. `textContent()`에는 직전 화면의 잔재가 섞인다. `tree.slice()`·`split()`으로 자르지 말고 정규식으로 찾는다.
- `isVisible()`은 요소가 없으면 예외를 던진다. `count()`를 먼저 본다. `goBack()`은 SPA라 timeout이 나니 `goto`를 쓴다.
- 착지 게이트에 `사용자 선언 표준 URL`을 쓰지 않는다(신규 URL은 `해당사항 없음`이다). `데이터 가져오는 중` 모달은 무시한다.
- 대기열 문구까지 1~2분 걸릴 수 있다(최대 150초 관측). 버튼을 다시 누르지 않는다.
- `실제 URL 테스트` 버튼을 먼저 누르지 않는다(모달이 5분 넘게 멈춘다). 요청 버튼이 테스트를 자동으로 한다.
- 버튼에 보이는 라벨(`색인 생성 요청`/`다시 요청`)로 요청 이력을 판정하지 않는다.
- **Aside가 재시작되면 REPL 함수와 탭이 사라지고, 세션 폴더(`~/.aside/u/0/sessions/<id>/artifacts`)도 지워질 수 있다**(11-14 실측). 오래 기다린 뒤에는 `typeof globalThis.<함수>`부터 확인하고, 원본은 바로바로 저장소 `.review/`로 복사한다.
- 탭이 `closeTab` 뒤에도 남는 경우가 있다(11-13 대화형 CLI, `session-desktop.ps1 aside`로 연 탭). 끝에 `listBrowserTabs()`로 확인하고, 남으면 보고한다.

### 3.3 읽기 작업 (보고서·Sitemaps)

- 보고서 딥링크(`…/index?resource_id=…`, `…/sitemaps?resource_id=…`)는 그대로 열린다. URL 검사는 딥링크가 없어 검사창을 거친다.
- **색인 목록 전수** — 보고서 → `색인이 생성된 페이지에 대한 데이터 보기` → `페이지당 행 수`를 보이는 쪽 컨트롤에서 100으로 → 행 수집 → 직전 표 잔재를 걷어낸 뒤 sitemap `<loc>`와 대조한다. 미색인은 사유 행을 눌러 같은 방법으로 받는다.
- `사이트맵 필터링`은 비활성이라 쓸 수 없다(처리된 sitemap이 없어서).
- CDP는 읽기 전용 폴백으로만 쓴다. 실적 보고서·`sitemaps.get` 조작법과 CDP 입력 요령은 `9214b90` 전체본 §6.1~§6.4에 있다.

---

## 4. 요청 원장 — 재요청 금지 판정의 유일한 근거

**고유 URL 230개.** 표기: `(ko/)x/` = `/x/`와 `/ko/x/`, `{a,b}` = 각각. 시각은 KST.
거절·실패·접수 불명(`/hi/blog/`)은 원장에 넣지 않는다. 중복 요청 3건(08-24 2건, 09-14 1건)은 합계에서 뺐다.
11-20 검산: 행 합계 230 = 고유 230, 전부 live sitemap 안에 있다. sitemap에서 원장 밖인 16개는 보류 1·요청 전에 이미 색인돼 있던 15개(`/`, `/ko/tech-notes/`, 초기 블로그 글 6쌍, `/apps/tokyometro/`)다. 다른 세션의 `Mobile light/docs/todo-google-search.md`에 기록된 손전등 홍보글 한·영 2건은 이미 합산돼 있다. 영문은 첫 시도 결과를 못 받은 뒤 버튼 라벨로 미접수라고 보고 재시도한 기록이 있으나, §3.2대로 라벨은 접수 판정 근거가 아니다. 성공 기록은 고유 URL당 한 번만 센다.

| 날짜 (KST) | 접수 | URL |
|---|---|---|
| 08-14 | 11 | `(ko/)apps/` · `(ko/)manual/` · `(ko/)apps/bt-keyboard/` · `(ko/)apps/wifi-scout/` · `(ko/)apps/lgtv/` · `/tech-notes/` |
| 08-17 | 10 | `(ko/)manual/{bt-keyboard,wifi-scout,lgtv}/` · `(ko/)apps/{bt-ppt,bt-mouse}/` |
| 08-24 | (2) | `(ko/)apps/lgtv/` — 08-14 중복 요청. 합계에서 뺀다 |
| 08-31 | 10 | `(ko/)tech-notes/{bt-keyboard,bt-ppt,bt-mouse,wifi-scout,ssh-scout}/` |
| 09-02 | 10 | `(ko/)tech-notes/lgtv/` · `(ko/)apps/ssh-scout/` · `(ko/)manual/{bt-ppt,bt-mouse,ssh-scout}/` |
| 09-05 | 10 | `(ko/)apps/yt-downloader/` · `(ko/)tech-notes/bt-keyboard/{why-google-tv-does-not-detect-bluetooth-hid,why-korean-english-key-labels-drift,sharing-one-bluetooth-hid-session}.html` · `/ko/` · `/blog/` |
| 09-10 | 5 | `/ko/blog/` · `(ko/)blog/use-android-phone-as-{bluetooth-mouse,powerpoint-remote}/` |
| 09-14 | 1 | `/apps/roman/` — 같은 URL 중복 요청 1건은 합계에서 뺀다 |
| 09-15 | 7 | `/ko/apps/roman/` · `(ko/)manual/roman/` · `(ko/)apps/{currency,numpad}/` |
| 09-16 | 2 | `(ko/)apps/unit/` |
| 09-17 | 10 | `/blog/techs/{windirstat-find-disk-hogs,windows-package-manager,makefile-as-command-list,explorer-vs-terminal,claude-desktop-vs-code-cli,alias-function-script,git-bash-windows-symlink,wezterm-unix-domain-persistence,wezterm-leader-cheatsheet,what-to-delegate-to-ai}/` |
| 09-18 | 10 | `/blog/techs/{wezterm-windows-korean-tmux,git-worktree-linear-merge,git-worktree-basics,claude-codex-shared-instructions}/` · `/ko/blog/techs/{windirstat-find-disk-hogs,windows-package-manager,makefile-as-command-list,explorer-vs-terminal,claude-desktop-vs-code-cli,alias-function-script}/` |
| 09-19 | 8 | `/ko/blog/techs/{git-bash-windows-symlink,wezterm-unix-domain-persistence,wezterm-leader-cheatsheet,what-to-delegate-to-ai,wezterm-windows-korean-tmux,git-worktree-linear-merge,git-worktree-basics,claude-codex-shared-instructions}/` |
| 09-22 | 10 | `/ko/blog/trending/economy/{gift-tax-exemption-limit,deposit-protection-combination,crypto-tax-timing,nonghyup-short-term-deposit,civil-servant-pay-raise-2027,tontine-pension-explained,parking-account-rates,irp-account-opening,early-reemployment-allowance,us-stock-market-hours}/` |
| 09-23 아침 | 2 | `/ko/blog/trending/economy/severance-pay-calculation-check/` · `/tech-notes/bt-keyboard/voice-input-over-bluetooth-hid.html` |
| 09-23 저녁 | 8 | `/ko/tech-notes/bt-keyboard/voice-input-over-bluetooth-hid.html` · `(ko/)apps/{receipt,namecard}/` · `(ko/)tech-notes/receipt/` · `/tech-notes/namecard/` |
| 09-25 | 10 | `/ko/tech-notes/namecard/` · `(ko/)blog/products/{scan-receipts-on-android-without-uploading,scan-business-cards-into-android-contacts}/` · `(ko/)apps/idphoto/` · `(ko/)tech-notes/idphoto/` · `/blog/products/make-korean-id-photos-on-android/` |
| 09-26 | 7 | `/ko/blog/products/make-korean-id-photos-on-android/` · `(ko/)blog/products/{receipt-scanner-app,business-card-scanner-app,id-photo-app}/` |
| 10-27 | 6 | `(ko/)apps/{morse,hannum,hangul}/` |
| 10-28 | 2 | `(ko/)blog/products/learn-hangul-app/` |
| 10-29 | 10 | `(ko/)apps/{seoulmetro,busanmetro}/` · `/{ja,zh-Hant,vi,es,fr,de}/blog/` |
| 10-30 | 4 | `(ko/)blog/products/{learn-korean-numbers,morse-code-decoder-app}/` — 다른 세션 |
| 10-31 | 2 | `(ko/)blog/products/seoul-subway-map-app/` — 다른 세션 |
| 11-04 | 10 | `(ko/)blog/products/{tokyo-subway-map-app,save-places-record-routes,alarm-snooze-schedule}/` — 다른 세션 · `/{it,pt-BR}/blog/` · `/{ja,zh-Hant}/blog/products/learn-hangul-app/` |
| 11-05 | 3 | `/{es,de,it}/blog/products/learn-hangul-app/` |
| 11-06 | 7 | `/{pt-BR,hi}/blog/products/learn-hangul-app/` · `/ko/apps/daegumetro/` · `(ko/)apps/gwangjumetro/` · `/{ja,es}/blog/products/seoul-subway-map-app/` |
| 11-12 11:30~11:47 | 9 | `(ko/)apps/{pedometer,gps}/` · `/{fr,de,it,pt-BR,hi}/blog/products/seoul-subway-map-app/` |
| 11-13 11:50~11:59 | 10 | `/ko/apps/koreametro/` · `/vi/blog/products/seoul-subway-map-app/` · `(ko/)blog/techs/wezterm-shortcut-menu/` · `(ko/)apps/alarm/` · `(ko/)blog/products/quick-nap-alarm/` · `/{vi,fr}/blog/products/learn-hangul-app/` |
| 11-14 12:07~12:15 | 10 | `/apps/daegumetro/` · `/ko/apps/tokyometro/` · `/zh-Hant/blog/products/seoul-subway-map-app/` · `/apps/koreametro/` · `(ko/)apps/{lunar,remote,vault}/` |
| 11-15 18:52~18:59 | 8 | `(ko/)apps/{daejeonmetro,qr,macropad,counter}/` |
| 11-16 06:56 | 2 | `(ko/)blog/products/flashlight-camera-app/` — 다른 세션 기록 합산. 이번 회차 재요청 없음 |
| 11-17 12:39~12:41 | 4 | `(ko/)blog/techs/everything-file-search-guide/` · `(ko/)apps/light/` |
| 11-18 14:42~14:43 | 2 | `(ko/)blog/products/photo-document-file-vault/` |
| 11-20 13:15~13:24 | 10 | `(ko/)blog/products/{qr-barcode-scanner-app,pc-youtube-remote,review-walking-route-details,korea-subway-regions}/` · `(ko/)blog/techs/herdr-in-wezterm/` |

---

## 5. 고정 정책 — 바꾸려면 사용자 결정이 필요하다

### 5.1 옛 URL 이동 신호

같은 속성 안의 경로 이동이다. GitHub Pages는 서버 301을 못 쓰므로 옛 URL에는 **0초 `meta refresh` + 새 URL canonical**만 둔다. 옛 URL은 sitemap과 내부 링크에서 뺐다. `noindex`는 08-14(`d6e04f0`)에 14개 모두 지웠다(이동 신호를 죽이므로). 서버 redirect가 되는 호스팅으로 옮기면 301/308로 바꾼다.

| 옛 URL (한·영) | 새 URL |
|---|---|
| `(ko/)bt-keyboard/` · `(ko/)bt-ppt/` · `(ko/)bt-mouse/` · `(ko/)wifi-scout/` · `(ko/)ssh-scout/` · `(ko/)yt-downloader/` · `(ko/)lgtv/` | 각각 `(ko/)apps/<같은 이름>/` |

### 5.2 하지 않는 것

- 옛 URL을 404로 만들거나, 홈·허브로 몰아 보내거나, 다단계 redirect로 잇지 않는다. **옛 URL 호환 페이지는 최소 2027-08-14까지 지우지 않는다.**
- 옛 URL을 sitemap에 다시 넣거나 색인 요청하지 않는다.
- 새 속성 생성, 주소 변경(Change of Address) 도구, 삭제(Removals) 도구를 쓰지 않는다.
- **Sitemaps 행 삭제·재제출은 사용자가 지시할 때만 한다.** 버릴 때는 GSC 행 삭제 → 파일 삭제 순서다.
- **소유권 확인 파일 3개를 지우지 않는다** — `googlec8773d84a9d25688.html`, `google6e10b6b19ade6d42.html`(각각 다른 소유자), `naver291cd179e909bd205a8a0bf7179d3588.html`.
- Play Console `스토어 설정 > 웹사이트`의 루트 URL을 `/apps/<app>/`로 바꾸지 않는다.
- 개인정보 처리방침 주소 `/#privacy-*`·`/ko/#privacy-*`는 바꾸지 않고 sitemap에 넣지 않는다(홈 안의 `id`다).
- `noindex` 일률 금지는 아니다. 시험용·임시 페이지에는 넣어도 된다.

---

## 6. 반복된 함정

- **`lastmod`는 페이지가 바뀐 날, `dateModified`는 글(본문)이 바뀐 날이다.** 링크 `href`만 바뀌면 `lastmod`만 올린다. 날짜만 고친 커밋은 날짜를 당기지 않는다. 혼합 커밋은 본문이 바뀐 파일만 골라 판단한다. `lastmod`를 고칠 때는 같은 URL의 `dateModified`·화면 날짜를 함께 본다.
- **`lastmod`와 다른 `dateModified` 30건은 정상이다**(08-31 코호트 28 · `(ko/)manual/roman/` 2). 단순 대조 스크립트 결과로 일괄 정정하지 않는다.
- CSS 토큰 `assets/site.css?v=20260817-blog-play-link`의 날짜 오기는 일부러 둔다. 이것을 08-17 배포의 증거로 읽지 않는다.
- 처리방침 `Effective date`는 처리방침 본문이 실질적으로 바뀐 배포에서만 올린다.
- **배포 커밋은 `--stat` 파일 목록을 끝까지 읽고 판단한다**(09-16 오판 사례).
- **새 배포가 `sitemap.xml`만 고치고 `sitemap-all.xml`을 빠뜨린 일이 다섯 번 있었다.** 어긋나면 `cp sitemap.xml sitemap-all.xml`(README '고칠 때')로 맞추고, 커밋은 다음 배포에 묶거나 사용자 지시를 받는다.
- GSC 화면에서 신호로 읽지 않는 것: URL 검사의 `Sitemaps` 칸, `페이지가 변경되었나요?` 문구, Sitemaps 상세 화면의 날짜(제출일일 뿐), 버튼 라벨.
- **요청 자동화는 입력 게이트·착지 게이트·즉시 기록이 한 세트다.** 빠지면 직전 URL을 다시 요청하거나(09-14 중복), 접수 후 기록 전에 죽었을 때 재요청한다.

---

## 7. 미해결 문제

### 7.1 sitemap이 처리되지 않는다

- 08-06 이후 네 번 제출했는데(`/sitemap.xml` 09-12 재제출, 복사본 `/sitemap-all.xml` 09-20 제출) 모두 `가져올 수 없음` · 발견 0이다. 제출하는 순간 한 번 시도하고 그 뒤 재시도가 없다.
- 사이트 쪽 결함은 없다(10-27 재확인: 200 · `application/xml` · 리디렉션 0 · XML·namespace·hreflang 정상 · `robots.txt` 정상). 크롤링 통계상 일반 크롤러는 08-31에 `/sitemap.xml`을 200으로 받아 갔다.
- 복사본 실험으로 **경로·제출 행은 원인이 아님**이 정해졌다. 내용·형식 변수는 아직 가르지 못했다 → 사용자 결정 3번(§2.5).
- 가장 유력한 설명은 Google이 밝힌 "크롤 수요가 낮으면 sitemap을 건너뛸 수 있다"이지만, 이 사이트에 적용됐다는 증거는 없다. 단정하지 않는다.
- **판별점** — `lastDownloaded`(읽은 날짜)가 생기거나, `isPending: false`와 `type`·`contents`가 나타나면 진전이다. 제출 직후의 `가져올 수 없음`은 판별력이 없다.
- 복사본 `sitemap-all.xml`만 처리되면 버리지 않고 `robots.txt`의 `Sitemap:` 줄을 그쪽으로 옮겨 정본으로 삼는다. Search Central 커뮤니티 문의는 작성·승인 전이다.
- 실무 영향은 작다. 새 페이지마다 색인 요청을 하는 지금 운용이 sitemap의 몫을 대신한다.

### 7.2 lgtv 새 URL을 옛 URL이 잠식한다

- **11-16 보고서에서 진전**: `/apps/lgtv/`·`/ko/apps/lgtv/`가 11-16 크롤 후 색인 목록으로 옮겨졌고 `다른 표준` 사유는 0이 됐다. 옛 스텁 `/lgtv/`·`/ko/lgtv/`도 색인 목록에 남아 있다. 새 URL 노출이 생기는지는 다음 실적 판독에서 본다. 아래는 그 전까지의 기록이다.
- `/apps/lgtv/`·`/ko/apps/lgtv/`의 Google 선택 표준이 옛 스텁 `/lgtv/`·`/ko/lgtv/`다(08-15 감지, 마지막 크롤 08-24, 11-09에도 같다). 실적에서도 새 URL 노출이 0이고 옛 스텁이 노출을 가져갔다(09-17 판독).
- 배제된 가설: 본문 중복, 한·영 상호 중복, 내부 링크 잔재. 사이트 태그도 모두 정확하다.
- 재요청은 이미 써 봤고 효과가 없었다(08-24). `noindex` 재도입·404·삭제 도구는 §5가 금지한다. **남은 조치는 재크롤을 기다리는 것뿐이다.**
- `다른 표준` 사유가 2개에 머무는지 본다. 옛 스텁 14개 전체가 위험 모집단이다.

---

## 8. 공식 참고 자료

- [Site Moves and Migrations](https://developers.google.com/search/docs/crawling-indexing/site-move-with-url-changes) · [Redirects and Google Search](https://developers.google.com/search/docs/crawling-indexing/301-redirects) · [Change of Address tool](https://support.google.com/webmasters/answer/9370220)
- [URL Inspection tool](https://support.google.com/webmasters/answer/9012289) · [Page indexing report](https://support.google.com/webmasters/answer/7440203)
- [Build and submit a sitemap](https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap) · [Sitemaps report](https://support.google.com/webmasters/answer/7451001) · [Sitemaps API get](https://developers.google.com/webmaster-tools/v1/sitemaps/get)
- [Canonicalization](https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls) · [Removals tool](https://support.google.com/webmasters/answer/9689846)
- sitemap `Couldn't fetch` 관련 Google 발언(2차 출처): [Search Engine Journal, 2026-10-06](https://www.searchenginejournal.com/google-explains-couldnt-fetch-sitemap-errors/) · 같은 증상 사례: [dev.to](https://dev.to/hexisteme/google-cant-fetch-your-github-pages-sitemap-but-bing-can-a-diagnosis-and-workaround-playbook-512k)
