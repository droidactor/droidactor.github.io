# droidactor.github.io

Developer site for the droidactor Android apps — app listing, per-app product pages, bilingual user
manuals and tech notes, support contact, privacy policy, and the host for `app-ads.txt`.

`https://droidactor.github.io/` 로 게시되는 GitHub Pages 사이트다. Play Console · App Store Connect 에
**개발자 웹사이트**로 등록하는 주소이며, AdMob 의 `app-ads.txt` 크롤러가 읽는 도메인 루트도 여기다.

## 구조

영문(`/`)과 국문(`/ko/`)이 **별도 URL** 이다. 예전처럼 한 페이지에 두 언어를 넣고 CSS 로 감추지 않는다 —
`display:none` 뒤의 텍스트는 검색엔진이 비중을 크게 낮춰서 한글 검색에 잡히지 않았다.

```
/                       영문 홈 (앱 목록 · 지원 · 개인정보 처리방침 전문)
/ko/                    국문 홈 (같은 구성, 같은 앵커)
/apps/                  제품 목록 — 7종 앱                            + /ko/apps/
/apps/bt-keyboard/      제품 페이지 — Dotori Bluetooth Keyboard      + /ko/apps/bt-keyboard/
/apps/bt-ppt/           제품 페이지 — Dotori Bluetooth PPT Remote    + /ko/apps/bt-ppt/
/apps/bt-mouse/         제품 페이지 — Dotori Bluetooth Mouse         + /ko/apps/bt-mouse/
/apps/wifi-scout/       제품 페이지 — Dotori WiFi Scanner             + /ko/apps/wifi-scout/
/apps/ssh-scout/        제품 페이지 — Dotori SSH Terminal             + /ko/apps/ssh-scout/
/apps/yt-downloader/    제품 페이지 — Dotori YouTube Downloader      + /ko/apps/yt-downloader/
/apps/lgtv/             제품 페이지 — Dotori LG TV Remote            + /ko/apps/lgtv/
/manual/                사용 설명서 목록 — 6종 앱                     + /ko/manual/
/manual/<앱>/           6종 앱 영문 사용 설명서                       + /ko/manual/<앱>/
                        (bt-keyboard · bt-ppt · bt-mouse · wifi-scout · ssh-scout · lgtv)
/tech-notes/            개발 기술 노트 목록 — 6종 앱                 + /ko/tech-notes/
/tech-notes/<앱>/       6종 앱 영문 기술 노트                        + /ko/tech-notes/<앱>/
                        (bt-keyboard · bt-ppt · bt-mouse · wifi-scout · ssh-scout · lgtv)
/tech-notes/<앱>/<slug>.html  주제별 상세 조사 글                    + /ko/tech-notes/<앱>/<slug>.html
/blog/                  글 목록 — Field notes                        + /ko/blog/ (현장 노트)
/blog/<slug>/           글 1편                                       + /ko/blog/<slug>/
/blog/_post-template.html  글 템플릿 — noindex · sitemap 제외. 페이지가 아니다
/assets/site.css        전 페이지 공용 스타일
/404.html               없는 주소 → 양 언어 홈으로 안내 (GitHub Pages 가 도메인 전역에 사용)
/robots.txt  /sitemap.xml
/app-ads.txt            AdMob 판매자 선언 (반드시 도메인 루트)
/.nojekyll              Jekyll 빌드 우회
/.gitignore             작업 메모(doit.txt)·리뷰 산출물이 공개 커밋에 딸려가지 않게 막는다
/googlec8773d84a9d25688.html   Google Search Console 소유권 확인 파일 — **지우면 소유권이 풀린다**
/naver291cd179e909bd205a8a0bf7179d3588.html  네이버 서치어드바이저 소유확인 파일 — 같은 이유로 **지우지 않는다**
```

제품의 예전 `/<앱>/` · `/ko/<앱>/` 주소는 이미 외부에 공개됐으므로 삭제하지 않는다. 각 주소에는
0초 `meta refresh`·새 canonical·본문 1:1 링크를 담은 호환 HTML을 두고, sitemap과 내부 링크는 새
`/apps/<앱>/` · `/ko/apps/<앱>/` 주소만 사용한다. GitHub Pages 정적 호스팅이라 서버 301은 쓸 수 없다.

**이 호환 페이지에 `noindex`를 넣지 않는다.** Google은 같은 사이트 안의 canonical 선택 수단으로
`noindex`를 권장하지 않고 redirect 또는 `rel="canonical"`을 쓰라고 안내한다. 셋을 같이 걸면 이동
신호가 서로 섞인다. 최초 개편 때 들어갔던 `noindex,follow`는 2026-08-14에 14개 전부 제거했다.

| 파일 | 역할 |
|---|---|
| `index.html` · `ko/index.html` | 앱 목록 + 지원 연락처 + **개인정보 처리방침 전문**. 처리방침 앵커의 정본이다 |
| `apps/index.html` · `ko/apps/index.html` | 7종 제품 목록 허브. 제품 상세와 6종 매뉴얼로 연결한다 |
| `apps/<앱>/index.html` · `ko/apps/<앱>/index.html` | 제품 상세. 기능·요구사항·개인정보 요약을 담고, 처리방침 **전문은 홈 앵커로 링크**한다(중복 금지) |
| `manual/index.html` · `ko/manual/index.html` | `yt-downloader`를 제외한 6종 사용 설명서 목록 허브 |
| `manual/<앱>/index.html` · `ko/manual/<앱>/index.html` | 6종 앱의 한·영 사용 설명서. 실제 UI 문구·검증 앱 버전·빠른 시작·설정·문제 해결을 담고 해당 제품·기술 글과 상호 링크한다. `yt-downloader`는 대상이 아니다 |
| `tech-notes/index.html` · `ko/tech-notes/index.html` | `yt-downloader`를 제외한 6종 개발 기술 노트 목록 허브 |
| `tech-notes/<앱>/index.html` · `ko/tech-notes/<앱>/index.html` | 6종 앱의 한·영 기술 노트. 소스 기준 버전과 구조·protocol·핵심 설계 결정·안전 경계·확인된 제약을 기록하고 제품·매뉴얼·현장 노트와 연결한다 |
| `blog/index.html` · `ko/blog/index.html` | 글 목록. **손으로 관리한다** — 이 리포에 생성기는 없다. 열 편쯤 넘어 손이 아프면 그때가 도입 신호다 |
| `blog/_post-template.html` | 글 템플릿. slug·경로·JSON-LD·CTA 규약을 머리주석에 담고 있으며 **글 추가 절차의 정본**이다 |
| `assets/site.css` | 전 페이지 공용. 외부 CDN·폰트·스크립트 없음(자기완결) |
| `sitemap.xml` | 홈 2 + 앱 허브 2 + 제품 14 + 매뉴얼 허브 2 + 매뉴얼 12 + 기술 노트 허브 2 + 기술 노트 14 + 블로그 18 = 66개 URL. 모든 한·영 쌍에 `xhtml:link` hreflang 3개를 둔다 |
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
| 앱별 처리방침 | `#privacy-<app key>` — `keyboard` · `ppt` · `mouse` · `wifi` · `ssh` · `ytdl` · `lgtv` · `gas` · `apartment` · `calendar` · `unit` (`apps.tsv` 등재 앱은 그 key 와 같다. 등재되지 않은 `gas`·`apartment`·`calendar`·`unit` 은 이 표가 정본) |
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
- 홈 2개, 앱 허브 2개, 제품 14개, 매뉴얼 허브 2개와 6종 한·영 매뉴얼 12개, 기술 노트 허브 2개와
  6종 한·영 기술 노트 12개, 주제별 한·영 상세 조사 글 2개. 매뉴얼과 기술 노트는 `TechArticle`, 제품은 `SoftwareApplication`으로
  역할을 분리하고 같은 언어끼리 상호 링크한다.
- `/blog/` · `/ko/blog/` — 제품 페이지보다 깊은 **기술 설명·정량 실측·원리·재현 가능한 상세 사용법**을
  싣는다. 측정 수치는 환경·방법·시점을 함께 적고, 적용 범위와 제약을 생략하지 않는다.
- 모든 사용자 유입형 사용 사례를 이 사이트에 먼저 만들지 않는다. Naver는 한국어 사용 사례의 원본,
  Blogger는 그 원고의 영어판을 맡으며, 사이트 글이 없는 Naver/Blogger 주제도 허용한다. 같은 주제를
  다루더라도 사이트는 기술 근거, Naver/Blogger는 사용 상황과 결과로 역할을 분리한다.
- 블로그 원고는 `MyApps/Mobile` 저장소 기준 `../blogs/<app>/<slug>/`에서 작성하고, 이 저장소에는 발행
  HTML과 발행 자산만 둔다. 발행 후 본문 수정도 `site.{en,ko}.md` 원고를 먼저 고친 뒤 HTML에 반영한다.
  채널별 역할은 `MyApps/Mobile/promotion/README.md` §2, 발행 순서는 같은 문서
  §5, 채널별 세부 규약은 `promotion/rules/*.md`가 정본이고, 근거는 `docs/todo-promotion.md` §3·§7이다.

**남은 것은 사람이 해야 한다 — Google Search Console 등록.** 이게 없으면 색인까지 몇 주가 걸린다.

1. <https://search.google.com/search-console> 에서 속성 추가 → **URL 접두어** 로
   `https://droidactor.github.io/` 입력 (도메인 속성은 DNS 를 요구하므로 `github.io` 에서는 불가)
2. 소유권 확인은 **HTML 파일 업로드** 방식이 이 리포에 맞는다. 현재 `googlec8773d84a9d25688.html` 이
   루트에 있다. **이 파일은 지우지 않는다** — 지우면 소유권이 풀리고 색인 요청 권한도 사라진다.
   확인 파일을 다시 발급받으면 옛 파일은 지우지 말고 새 파일을 함께 둔다(둘 다 유효하다).
3. 좌측 **Sitemaps** 에 `sitemap.xml` 제출
4. **URL 검사**에 `https://droidactor.github.io/` 를 넣고 **색인 생성 요청**. 주요 제품 페이지도 같은 방식으로
   한 번씩 요청한다(하루 할당량이 있어 16개를 한 번에 다 넣지는 못한다)

### 네이버 서치어드바이저

Google Search Console 과 **별개 경로**다. 한국어 검색 유입의 상당 부분을 네이버 통합검색이 받으므로
같은 사이트를 여기에도 등록한다. 네이버 블로그 운영과도 별개다 — 이것은 자체 도메인을 네이버 색인에
넣는 작업이다.

1. <https://searchadvisor.naver.com> → **웹마스터 도구** → 사이트 등록에
   `https://droidactor.github.io/` 를 입력한다
2. 소유확인은 **HTML 파일 업로드** 방식을 쓴다(네이버 권장이고 Google 확인 파일과 같은 방식이라
   이 리포에 맞는다). 현재 `naver291cd179e909bd205a8a0bf7179d3588.html` 이 루트에 있다.
   **이 파일은 지우지 않는다** — 지우면 소유권이 풀린다.
   **파일을 push 한 뒤 GitHub Pages 배포가 끝난 것을 확인하고 나서 "소유확인" 을 누른다.**
   배포 전에 누르면 실패한다(Google 사이트맵에서 실제로 겪은 것과 같은 함정이다).
   버튼을 누르면 **자동등록 방지 캡차**가 뜬다 — 사람이 통과해야 하는 단계다
3. 소유확인이 통과하면 **요청 → 사이트맵 제출**에 사이트맵을 넣는다.
   **입력 필드는 경로가 아니라 전체 URL 을 받는다.** `sitemap.xml` 만 넣으면 확인을 눌러도
   오류 메시지 하나 없이 입력칸만 비워지고 목록에는 아무것도 남지 않는다(2026-08-10 실측 —
   "제출됐는데 목록이 늦게 반영되나" 로 오해하기 딱 좋다). placeholder 가 도메인 전체 URL 인 것이
   그 신호다. `https://droidactor.github.io/sitemap.xml` 을 통째로 넣는다
4. **요청 → 웹 페이지 수집**이 Google 의 "색인 생성 요청" 에 해당하는 자리다. 사이트맵과 별개 경로이고
   **한 건씩 넣는다.** 입력 필드는 사이트맵 제출과 같이 **전체 URL 을 받고**, 등록되면 목록에는 경로만
   표시된다(`https://droidactor.github.io/ko/` → `/ko/`). 콘솔은 "요청 횟수는 사이트별로 제한될 수
   있으며, 최근 한 달 이내의 요청 결과만 제공합니다" 라고만 안내하고 한도를 밝히지 않는다.
   **자동화 함정** — 이 입력칸은 Chromium 이 UIA `ValuePattern` 쓰기를 거부하므로 클립보드 붙여넣기가
   유일한 주입 경로이고, `확인` 버튼은 **UIA `Invoke` 로는 Vue 핸들러가 걸리지 않아 물리 클릭이 필요하다.**
   등록 직후 UIA 트리로 목록을 읽으면 갱신 전 상태(`데이터가 없습니다.`)가 잡히므로 **성공 판정을
   트리 읽기로 하지 말고 잠시 뒤 다시 읽는다** (2026-08-11 실측, 셋 다 실제로 겪었다).

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
- [x] **색인 생성 요청 2건 추가 + 일일 할당량 실측 (2026-08-10 오후).**
      `control-lg-webos-tv-over-wifi` 의 en/ko 짝을 넣어 둘 다 "우선순위 크롤링 대기열에 추가" 를
      받았다. 이어서 넣은 `/blog/find-ls-plc-ip-address/` 에서 **"일일 할당량을 초과하여 이 요청을
      처리할 수 없습니다. 내일 다시 제출해 주세요."** 가 떴다.
      **그래서 이 계정·이 사이트의 하루 할당량은 12건이다**(오전 10 + 오후 2 통과, 13번째 거부).
      위 항목들이 "10건 안팎" 으로 적어 온 값이 실측으로 좁혀진 것이다. 다만 Google 이 공개한
      수치가 아니므로 12를 보장값으로 쓰지 않는다 — 거부 메시지가 나오면 그날은 멈춘다.
      같은 시점 보고서는 색인됨 `6` · 색인 안 됨 `3` 으로 오전과 같았다. 당일 요청분이 아직
      반영되지 않은 것은 정상이다.
- [x] **색인 생성 요청 1건 + 할당량 리셋 시점 실측 (2026-08-11 05:37).**
      `/blog/find-ls-plc-ip-address/` 가 "우선순위 크롤링 대기열에 추가" 를 받았고, 바로 이어 넣은
      그 한국어 짝 `/ko/blog/find-ls-plc-ip-address/` 에서 8-10 과 같은 **"일일 할당량을 초과하여 이
      요청을 처리할 수 없습니다"** 가 떴다. UIA 트리에서 그 창을 직접 확인했으므로 오탐이 아니다.
      **그래서 할당량은 KST 자정에 리셋되지 않는다** — 날짜가 바뀐 뒤인데 잔여가 1건뿐이었다.
      같은 날 **09:11 에 재개하니 10건이 연속으로 통과했다**(거부 없음). 즉 경계는
      **UTC 자정 = KST 09:00** 이고, **색인 요청 작업은 09:00 이후에 시작한다**가 실행 규칙이다.
      **상한과 회복 방식은 여전히 미확정이고 단순 일일 카운터도 아니다** — 8-10 15:07 에 13번째가
      거부됐는데(⇒ 상한 12) 05:37 에 한 건이 통과했다(⇒ 13번째 통과). 그 사이 14시간 반 동안 한
      건분이 회복된 것처럼 보이나 관측 세 점으로 단정하지 않는다. **12 도 13 도 보장값으로 쓰지 않고
      거부 메시지가 나오면 그날은 멈춘다.** 09:00 이후에도 10건까지만 확인됐다.
      같은 시점 보고서는 색인됨 `6` · 색인 안 됨 `3` 으로 8-10 과 같았는데, 이번에 그 이유를 찾았다 —
      보고서 상단에 **`최종 업데이트: 26. 8. 7.`** 이 붙어 있다. 데이터가 나흘 지연돼 있으니 8-08
      이후의 크롤은 아직 이 화면에 나올 수 없다. **다음부터 수치보다 이 날짜를 먼저 읽는다.**
- [x] **sitemap 34 URL 전부 색인 요청 완료 (2026-08-11 09:26).** 09:11~09:26 에 남은 10건을 넣어
      전부 "우선순위 크롤링 대기열에 추가" 를 받았다 — 블로그 3개(`find-ls-plc-ip-address` 의 한국어
      짝과 `identify-industrial-devices-by-port` 의 en/ko 짝)로 블로그 8종 16 URL 을 끝내고, 한국어
      제품 7개(`/ko/bt-keyboard/` `/ko/bt-ppt/` `/ko/bt-mouse/` `/ko/wifi-scout/` `/ko/ssh-scout/`
      `/ko/yt-downloader/` `/ko/lgtv/`)를 이어 넣었다.
      요청 이력을 합치면 sitemap 과 정확히 맞는다 — **이미 색인된 루트 1 + 8-08 의 10 + 8-10 의 12 +
      8-11 의 11 = 34.**
      `/bt-ppt/` `/yt-downloader/` 는 크롤이 아직 닿지 않았지만 8-08 에 이미 요청했으므로 다시 넣지
      않았다(대화상자가 명시한다 — "페이지를 여러 번 제출해도 대기열 위치나 우선순위가 변경되지
      않습니다"). **단 할당량으로 거부된 요청은 이 규칙의 대상이 아니다** — 대기열에 들어가지 못했으니
      다시 넣는 것이 맞고, 8-11 05:37 에 거부된 한국어 짝을 그렇게 처리했다.
      자동화에서 2건이 한 번 실패했다. 원인은 타이밍이 아니라 **"요청 버튼이 보이면 누른다" 는 판정이
      어느 URL 의 화면인지 묻지 않는다**는 구조였다 — 앞 단계가 실패해 화면이 앞 URL 에 머물면 그것을
      재요청한다. 화면의 URL 을 먼저 확인하도록 고쳐 10건을 연속 통과시켰다(URL 당 22~25초).
      절차와 스크립트 정본은 `MyApps/Mobile/admob/todo-google-search.md` §4 다.
      (숫자의 이력 — 처음의 "남은 11개" 는 sitemap 이 22 URL 이던 시점 기준이다. 8-08 에 블로그
      6종이 추가돼 34 URL 이 되면서 "남은 13개" 가 됐고, 8-10 오후 2건으로 11개, 8-11 05:37 의 1건으로
      10개, 그리고 09:26 에 0 이 됐다. **중간의 11 은 맨 처음의 11 과 기준이 다르다 — 우연히 같은
      숫자였다.** 34개 중 Google 이 아는 것은 아직 9개다 — 2026-08-11 재확인, 단 보고서 기준일 8-07.)
- [ ] **경로 개편 전 요청한 34 URL 의 크롤·색인 도달 관찰.** 이 항목은 2026-08-14 경로 개편 전
      색인 이력을 추적하는 기록이다. 당시 기준으로는 넣을 것이 없었으므로 남은 일은 기다림이었다.
      크롤이 닿지 않은 URL 이 있어도 **재요청하지 않는다**(대기열 우선순위가 바뀌지 않는다).
      볼 순서는 `todo-google-search.md` §5-2 — **보고서 최종 업데이트 날짜를 먼저 읽고**, 그것이
      움직였을 때만 수치를 본다.
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
- [x] **`badge soon` → 스토어 배지 교체 완료 (2026-08-14).** `bt-ppt` · `bt-mouse` · `ssh-scout` 가
      프로덕션에 올라 6종(`bt-keyboard` `bt-ppt` `bt-mouse` `wifi-scout` `ssh-scout` `lgtv`)이 모두
      출시 상태가 됐다. 교체 전에 6종의 `play.google.com/store/apps/details?id=…` 가 **로그아웃
      상태에서 `200`** 인지 확인했다(`yt-downloader` 만 `404`). **이 항목이 적어둔 "앱당 4곳" 은
      2026-08-02 당시 구조에서만 맞는 값이었다** — 8-10 에 블로그 글 CTA 로 배지가 들어가고
      8-14 경로 개편으로 매뉴얼이 생기면서 어긋났는데 그때 이 줄을 갱신하지 않았다.
      **곳 수는 앱마다 다르다** — 이번 세 앱은 각 8곳, `wifi-scout` 은 CTA 블로그가 3편이라 12곳,
      매뉴얼도 CTA 글도 없는 `yt-downloader` 는 4곳이다. 그래서 고정 숫자 대신 판정 규칙을
      "고칠 때 → 앱이 출시되면" 에 적었다. 홈 2곳은 세 앱이 같은 파일을 공유하므로 이번에 고친 파일은
      앱 전용 18개(제품·매뉴얼·블로그 각 2 × 3앱) + 홈 2개 = 20개다.
      남은 미출시 앱은 `yt-downloader` 하나뿐이다.
- [x] **네이버 서치어드바이저 등록 · 소유확인 · 사이트맵 제출 (2026-08-10).** 웹마스터 도구에
      `https://droidactor.github.io/` 를 등록하고 HTML 파일 방식으로 소유확인을 마쳤다. 확인 파일을
      `687f2cd` 로 push 한 뒤 `https://droidactor.github.io/naver291cd179e909bd205a8a0bf7179d3588.html`
      이 `200`(67바이트, 내용 일치)을 돌려주는 것을 확인하고 눌렀다. 사이트맵은 `26.08.10 14:47:50` 에
      등록됐다. 첫 제출이 조용히 실패한 원인은 위 "네이버 서치어드바이저" 절 3번에 적었다.
      **네이버는 사이트맵을 즉시 처리하지 않는다** — 처음 소유확인한 사이트는 리포트 생성까지 시간이
      걸린다고 콘솔이 안내한다. 수집·색인 현황은 며칠 뒤에 본다
- [x] **네이버 웹 페이지 수집 요청 34건 = 사이트맵 전량 (2026-08-11 06:52~06:57).**
      한국어 17개를 먼저 넣고(`/ko/` → `/ko/blog/` → `/ko/wifi-scout/` → 나머지 제품·글) 영문 홈 `/` 에
      이어 영문 16개를 넣었다. **한 건도 거부되지 않았고 목록에 34건이 그대로 남았다** —
      Google 색인 요청이 12~13건에서 막히는 것과 대조된다. 다만 콘솔이 한도를 밝히지 않으므로
      "34건은 통과한다" 를 보장값으로 쓰지 않는다. 한국어를 먼저 넣은 이유는 네이버 통합검색이
      받는 것이 한국어 문서이고, 그중에서도 유일 출시 앱인 `wifi` 계열을 앞에 두었기 때문이다.
      같은 날 요약 화면은 노출/클릭·진단·수집 세 카드 모두 `정보가 없습니다` 였다(소유확인 다음날이라
      리포트 미생성). **수집 결과는 며칠 뒤에 본다.**
- [ ] 네이버 수집·색인 현황 확인. 위 34건 중 실제로 수집된 것이 몇 개인지 `요약 → 수집 현황` 과
      `리포트` 에서 확인하고, Google 쪽 진행과 나란히 비교한다.
- [ ] 제품 페이지에 스크린샷 추가(현재는 텍스트만). 이미지를 넣으면 `og:image` 도 함께 채운다.
- [ ] **2026-08-14 경로 개편 배포 확인.** 배포 뒤 `/apps/`·`/manual/` 허브, 7종 새 제품 URL,
      6종 새 매뉴얼 URL과 기존 제품 URL 14개의 호환 이동이 실제 도메인에서 `200`인지 확인한다.
      sitemap 주소 자체는 그대로이므로 삭제·재제출하지 말고 Search Console의 재수집을 기다린다.
      URL 검사는 우선 `/apps/`, `/ko/apps/`, `/manual/`, `/ko/manual/`과 이미 색인됐던 제품의 새 주소부터
      요청한다. 네이버도 같은 새 canonical URL을 수집 요청하되 콘솔이 거부하면 그날은 중단한다.

지원·개인정보 문의 주소는 `droidactor@gmail.com` 이다(홈의 Support 섹션과 §8).
개인정보 처리방침의 연락처는 Play 정책상 필수 항목이므로 비워두지 않는다.

## 고칠 때

- **앱을 추가하면** 다음을 한 묶음으로 처리한다. 하나라도 빠지면 링크가 깨지거나 색인에서 누락된다.
  1. 홈 카드 2개 — `index.html`, `ko/index.html` 의 `<article class="card">`
  2. 처리방침 앱별 항목 2개 — 같은 두 파일의 `<div class="policy" id="privacy-…">`
  3. 제품 페이지 2개 — `apps/<앱>/index.html`, `ko/apps/<앱>/index.html`
  4. `sitemap.xml` 에 URL 2개 (hreflang 3줄씩)
  5. 새 권한이 생기면 처리방침 §4 권한 표에 행 추가 (두 언어 모두). 기존 권한을 쓰는 앱이라도
     그 행의 "해당 앱" 칸에 이름을 더한다
  6. 홈 JSON-LD `ItemList` 에 `ListItem` 2개 (`index.html` · `ko/index.html`, position 은 카드 순서)
  7. **역방향 링크** — 기존 모든 페이지의 `<div class="also">` 에 새 앱을 넣는다. 기존 한·영 제품 페이지 전부 + 앱·블로그 목록
     + `404.html` 이고, 새 제품 페이지 쪽에는 나머지 앱 전부를 넣는다. 여기를 빠뜨리면 홈 카드 외에는
     새 앱으로 들어가는 내부 링크가 없어 크롤러가 한 경로로만 본다(bt-mouse 를 붙일 때 실제로 빠뜨렸다)
  8. 손댄 페이지의 `<lastmod>` 갱신
- **앱이 출시되면** `badge soon` 을 스토어 배지로 바꾼다. **곳 수를 숫자로 외우지 말고 아래 규칙으로
  센다** — 앱마다 다르다(2026-08-14 기준 `bt-keyboard`·`bt-ppt`·`bt-mouse`·`ssh-scout`·`lgtv` 는 8곳,
  `wifi-scout` 은 12곳, `yt-downloader` 는 4곳). 홈과 제품 페이지만 고치고 끝내면 매뉴얼·블로그에는
  여전히 배지가 없다.
  1. 홈 카드 2곳 — `index.html`, `ko/index.html` 의 `<div class="foot">`. **항상 있다**
  2. 제품 페이지 2곳 — `apps/<앱>/`, `ko/apps/<앱>/` 의 `<div class="status">`. **항상 있다.**
     같은 파일의 사양표 `Status`/`상태` 행도 함께 발행 문구로 바꾼다
  3. 매뉴얼 2곳 — `manual/<앱>/`, `ko/manual/<앱>/` 의 `<div class="manual-actions">` 맨 끝.
     **그 앱의 매뉴얼이 있을 때만이다** — `yt-downloader` 에는 매뉴얼도 기술 노트도 없다
  4. 그 앱을 CTA 로 두는 **블로그 글 전부**(글 1편당 en/ko 2곳) — 마무리 `<div class="note">` 안에
     배지 문단을 더한다. **1편이라고 가정하지 말고 센다** — `wifi-scout` 은 3편(`find-devices-on-wifi-
     from-android` · `find-ls-plc-ip-address` · `identify-industrial-devices-by-port`)이라 6곳이다.
     `grep -rl 'apps/<앱>/' blog/ ko/blog/` 로 뽑는 것이 확실하다
  5. 손댄 페이지의 `sitemap.xml` `<lastmod>` 갱신
  - **배지를 새로 넣은 페이지에는 푸터 `<p class="tm">` 상표 고지가 반드시 함께 들어간다.** Google 의
    배지 가이드라인 요구사항이고, 배지만 넣고 고지를 빠뜨린 페이지가 생기기 쉽다
  - 이미지 경로는 페이지 깊이마다 다르다 — 홈 `assets/`(`/ko/` 는 `../assets/`), 그 외 영문은
    `../../assets/`, 국문은 `../../../assets/`. 파일은 영문 `-en`, 국문 `-ko` 를 쓴다
  - **교체 시점의 판정은 로그아웃 상태에서 스토어 URL 이 `200` 인지 하나뿐이다.** Console 이 "게시됨"
    으로 보여도 내부 테스트 트랙이면 테스터 외에는 `404` 라 배지가 죽은 링크가 된다
- **6종 앱 매뉴얼을 고치면** 제품 소개나 블로그 설명과 섞지 않고 다음을 한 묶음으로 처리한다.
  1. `manual/<앱>/index.html`과 `ko/manual/<앱>/index.html`을 같은 목차·같은 기능 범위로 갱신
  2. 화면의 실제 버튼명은 앱 리소스 문자열, 동작·권한은 앱 코드와 `AndroidManifest.xml`을 근거로 확인
  3. 문서 머리의 검증 앱 버전과 `dateModified`, `sitemap.xml`의 `<lastmod>`를 함께 갱신
  4. 제품 페이지의 매뉴얼 CTA와 해당 기술 글의 관련 글 링크가 양방향으로 살아 있는지 확인
  5. 스크린샷은 기존 블로그 자산을 참조한다. 발행된 자산 경로를 매뉴얼 때문에 이동하거나 복제하지 않는다
- **6종 앱 기술 노트를 고치면** 사용법이 아니라 구현 근거를 유지한다.
  1. `tech-notes/<앱>/index.html`과 `ko/tech-notes/<앱>/index.html`을 같은 목차·같은 기술 범위로 갱신
  2. 구조·protocol·수치·제약은 `MyApps/Mobile/master`의 현재 앱 소스와 test를 근거로 확인
  3. 머리의 source 기준 버전과 `dateModified`, `sitemap.xml`의 `<lastmod>`를 함께 갱신
  4. 제품·매뉴얼·관련 현장 노트로 가는 같은 언어 링크가 살아 있는지 확인
  5. 미출시 기능이나 source에서 확인하지 않은 동작을 확정형으로 기록하지 않는다
- **블로그 글을 추가하면** 다섯 가지를 한 묶음으로 처리한다. 자리표시자와 세부 규약의 정본은
  `blog/_post-template.html` 머리주석이며, 작성 원고는 `MyApps/Mobile` 저장소 기준
  `../blogs/<app>/<slug>/site.{en,ko}.md`에서 가져온다.
  1. `blog/<slug>/index.html`(`lang="en"`) · `ko/blog/<slug>/index.html`(`lang="ko"`) —
     **slug 는 두 언어가 같은 문자열이다.** 그래야 hreflang 쌍이 기계적으로 맞는다
  2. 두 목록 페이지에 `<li>` 추가 — `blog/index.html`, `ko/blog/index.html`
  3. `sitemap.xml` 에 글 URL 2개. **첫 글이라면 주석 처리된 블로그 목록 쌍도 이때 함께 푼다**
  4. 손댄 페이지의 `<lastmod>` 갱신
  5. 글 끝 CTA 는 **앱 하나만** 가리킨다. 다섯 개를 나열하면 아무 데도 가지 않는다
- **전역 네비게이션 항목이 늘면**(블로그나 매뉴얼처럼 새 섹션이 생기면) 푸터가 있는 **모든 페이지**를 고친다 —
  홈 2 + 허브 8 + 제품 14 + 매뉴얼 12 + 기술 노트 12 + 블로그 글 16 + `404.html`. 홈만 고치면 나머지 페이지에서 그 섹션에 닿을 길이 없고,
  크롤러도 홈 한 곳에서만 링크를 본다. 블로그를 붙일 때 실제로 여기서 한 번 빠뜨렸다.
- **개인정보 처리방침을 고치면** 섹션 머리의 "최종 갱신 / Effective date" 날짜를 함께 고친다. **두 언어 모두다.**
- **제품 페이지에 처리방침 전문을 복사하지 않는다.** 요약 + 홈 앵커 링크만 둔다. 두 벌이 되면 반드시 어긋난다.
- 권한 설명은 추측하지 않고 각 앱의 `AndroidManifest.xml` 을 근거로 쓴다. 위치 권한 없음,
  `NEARBY_WIFI_DEVICES` 의 `neverForLocation` 처럼 심사에서 문제되는 항목은 매니페스트가 근거다.
- 앱 목록·패키지명·출시 상태·버전·minSdk 의 정본은 이 리포가 아니라 `MyApps/Mobile/master/apps.tsv` 다.
- 스타일을 고칠 일이 있으면 `assets/site.css` 한 곳만 고친다. 페이지에 `<style>` 을 다시 넣지 않는다.

## 확인

내부 링크가 `/apps/bt-keyboard/` 같은 **절대경로**라 `file://` 로 열면 링크가 동작하지 않는다. 로컬 확인은
정적 서버로 한다.

```sh
python -m http.server 8000     # 그리고 http://localhost:8000/ 을 연다
```

게시 설정은 `Settings → Pages → Source = Deploy from a branch`, `main` / `/ (root)`.

AdMob 콘솔의 app-ads.txt 상태가 "확인됨" 으로 바뀌는 데 하루 이상 걸린다. 반영이 늦다고 파일을 계속
고치지 말고, `https://droidactor.github.io/app-ads.txt` 가 브라우저에 그대로 보이는지만 확인한다.
