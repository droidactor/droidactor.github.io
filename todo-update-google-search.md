# Google Search URL 변경 후속 작업

작성일: 2026-08-14

기준 변경: `f300f26` — 앱·매뉴얼 URL 구조 개편

후속 변경: 6개 앱의 한·영 Tech Notes 14개 추가, 이후 bt-keyboard 상세 노트 6개 추가(§9, §10)

## 1. 결론

이번 변경은 도메인이나 protocol 변경이 아니라 **같은 Search Console 속성 안에서 URL path만 바꾼 것**이다.

- 기존 Search Console 속성 `https://droidactor.github.io/`를 그대로 사용한다.
- 새 속성을 추가하지 않는다.
- **주소 변경(Change of Address) 도구는 사용하지 않는다.** Google은 같은 사이트 안의 path 이동에는
  redirect와 sitemap 갱신을 사용하라고 명시한다.
- Search Console의 **삭제(Removals) 도구로 옛 URL을 지우지 않는다.** 이 도구는 content 이동용이 아니며,
  redirect·canonical 신호의 정상 처리를 방해할 수 있다.
- sitemap 제출 주소는 계속 `https://droidactor.github.io/sitemap.xml`이다.
- 경로 개편으로 생긴 새 canonical URL 30개와 Tech Notes 계열 20개, 합계 50개를 sitemap으로 알린다.
  (Tech Notes 20개 = §2.3 의 14개 + §9 의 2개 + §10 의 4개. sitemap 총 URL 은 여기에 §2.4 의 20개를
  더한 **70개**다. 아래 본문의 44·64·66 은 각각 8-14·8-15 시점의 실측 기록이므로 그대로 둔다.)
  경로 개편 핵심 URL 10개를 먼저 URL 검사 → 색인 생성 요청하고, Tech Notes 허브 2개는 다음 요청일에
  확인한다. 나머지는 7~14일 뒤에도 미발견·비색인일 때 원인을 확인한 후 선별 요청한다.
- 옛 제품 URL 14개는 최소 1년, 가능하면 계속 유지하되 현재 호환 페이지의 `noindex,follow`는 제거한다.

근거:

- [Google: URL 변경을 수반한 사이트 이동](https://developers.google.com/search/docs/crawling-indexing/site-move-with-url-changes)
- [Google: 주소 변경 도구를 사용하지 않는 경우](https://support.google.com/webmasters/answer/9370220)
- [Google: Redirect와 Google Search](https://developers.google.com/search/docs/crawling-indexing/301-redirects)
- [Google: 삭제 도구를 사용하지 않는 경우](https://support.google.com/webmasters/answer/9689846)

## 2. 변경 범위

### 2.1 이동한 기존 제품 URL — 14개

| 언어 | 이전 URL | 새 canonical URL |
|---|---|---|
| en | `/bt-keyboard/` | `/apps/bt-keyboard/` |
| ko | `/ko/bt-keyboard/` | `/ko/apps/bt-keyboard/` |
| en | `/bt-ppt/` | `/apps/bt-ppt/` |
| ko | `/ko/bt-ppt/` | `/ko/apps/bt-ppt/` |
| en | `/bt-mouse/` | `/apps/bt-mouse/` |
| ko | `/ko/bt-mouse/` | `/ko/apps/bt-mouse/` |
| en | `/wifi-scout/` | `/apps/wifi-scout/` |
| ko | `/ko/wifi-scout/` | `/ko/apps/wifi-scout/` |
| en | `/ssh-scout/` | `/apps/ssh-scout/` |
| ko | `/ko/ssh-scout/` | `/ko/apps/ssh-scout/` |
| en | `/yt-downloader/` | `/apps/yt-downloader/` |
| ko | `/ko/yt-downloader/` | `/ko/apps/yt-downloader/` |
| en | `/lgtv/` | `/apps/lgtv/` |
| ko | `/ko/lgtv/` | `/ko/apps/lgtv/` |

GitHub Pages에서는 server-side `301`을 설정할 수 없으므로 현재 배포된 옛 URL은 다음 신호를 함께 사용한다.

- `meta refresh` 0초 → 대응하는 최종 URL로 직접 이동
- 새 URL을 가리키는 `rel="canonical"`
- sitemap과 내부 링크에서는 옛 URL을 제거

최초 개편 때는 여기에 `noindex,follow`도 함께 걸었으나 **2026-08-14 commit `d6e04f0` 으로 제거했다.**
아래 정리 항목이 그 작업이며, 지금 배포된 신호는 위 세 가지뿐이다.

Google은 0초 `meta refresh`를 permanent redirect 신호로 처리한다. 다만 Google은 같은 사이트 안의 canonical
선택 수단으로 `noindex`를 권장하지 않고 redirect 또는 `rel="canonical"`을 사용하라고 안내한다. 이동 신호가
불필요하게 섞이지 않도록 Search Console 작업 전에 다음 상태로 정리했다.

- [x] 옛 호환 페이지 14개에서 `<meta name="robots" content="noindex,follow">`를 제거한다.
      2026-08-14 commit `d6e04f0` 로 14개 전부 제거·배포했다. README 의 호환 페이지 설명도 함께 고쳤다.
- [x] 0초 `meta refresh`, 새 URL canonical, 새 URL로 가는 1:1 링크는 유지한다.
      제거 전후 모두 14개 전부 `content="0; url=<대응 새 URL>"`로 1:1 정확.
- [x] 변경을 배포한 뒤 옛 URL 14개의 live HTML에 `noindex`가 없고 대상 URL이 정확한지 확인한다.
      2026-08-14 11:46 KST 배포 반영 확인. 14/14 가 `200` + `noindex` 없음 + `meta refresh` 1:1 정확 +
      canonical 이 대응 새 URL. 이제 이동 신호는 `meta refresh` + `rel="canonical"` 둘뿐이다.

Server-side `301`/`308`이 가장 권장되지만, 현재 GitHub Pages 제약에서는 0초 `meta refresh`가 공식적으로
인정되는 대안이다. 향후 server redirect를 설정할 수 있는 hosting으로 옮기면 `301`/`308`로 교체한다.

### 2.2 완전히 새로 추가한 URL — 16개

허브 4개:

- `https://droidactor.github.io/apps/`
- `https://droidactor.github.io/ko/apps/`
- `https://droidactor.github.io/manual/`
- `https://droidactor.github.io/ko/manual/`

매뉴얼 12개:

- `https://droidactor.github.io/manual/bt-keyboard/`
- `https://droidactor.github.io/ko/manual/bt-keyboard/`
- `https://droidactor.github.io/manual/bt-ppt/`
- `https://droidactor.github.io/ko/manual/bt-ppt/`
- `https://droidactor.github.io/manual/bt-mouse/`
- `https://droidactor.github.io/ko/manual/bt-mouse/`
- `https://droidactor.github.io/manual/wifi-scout/`
- `https://droidactor.github.io/ko/manual/wifi-scout/`
- `https://droidactor.github.io/manual/ssh-scout/`
- `https://droidactor.github.io/ko/manual/ssh-scout/`
- `https://droidactor.github.io/manual/lgtv/`
- `https://droidactor.github.io/ko/manual/lgtv/`

`yt-downloader`는 제품 URL만 이동했으며 매뉴얼은 추가하지 않았다.

### 2.3 후속 추가한 Tech Notes URL — 14개

허브 2개:

- `https://droidactor.github.io/tech-notes/`
- `https://droidactor.github.io/ko/tech-notes/`

6개 앱의 한·영 기술 노트 12개:

- `https://droidactor.github.io/tech-notes/bt-keyboard/`
- `https://droidactor.github.io/ko/tech-notes/bt-keyboard/`
- `https://droidactor.github.io/tech-notes/bt-ppt/`
- `https://droidactor.github.io/ko/tech-notes/bt-ppt/`
- `https://droidactor.github.io/tech-notes/bt-mouse/`
- `https://droidactor.github.io/ko/tech-notes/bt-mouse/`
- `https://droidactor.github.io/tech-notes/wifi-scout/`
- `https://droidactor.github.io/ko/tech-notes/wifi-scout/`
- `https://droidactor.github.io/tech-notes/ssh-scout/`
- `https://droidactor.github.io/ko/tech-notes/ssh-scout/`
- `https://droidactor.github.io/tech-notes/lgtv/`
- `https://droidactor.github.io/ko/tech-notes/lgtv/`

`yt-downloader`는 Tech Notes 대상에서도 제외했다. 이 14개는 이전 URL이 없는 신규 문서이므로 redirect나
주소 변경 처리는 하지 않고 sitemap, 내부 링크, self canonical로 발견을 알린다.

### 2.4 변경되지 않은 URL — 20개

- 한·영 홈 2개
- 한·영 블로그 허브 2개
- 한·영 블로그 글 16개

이 URL들은 path가 바뀌지 않았으므로 별도의 이동 처리는 필요 없다. 이번 배포에서 내부 링크가 바뀌었으므로
Google이 다시 crawl하면 갱신된 link graph를 읽는다.

## 3. 배포 확인

2026-08-14에 기준 변경 `f300f26`의 다음 live 응답을 확인했다. 아래 `noindex` 제거와 ytdl `lastmod`
정정은 별도 후속 commit으로 배포해야 한다.

- `/apps/` → `200`, self canonical 정상
- `/manual/` → `200`, self canonical 정상
- `/bt-keyboard/` → `200`, canonical `/apps/bt-keyboard/`, `meta refresh` 0초 정상; 현재 `noindex`는 제거 필요
- `/sitemap.xml` → `200`, 50개 canonical URL(Tech Notes 배포 전 live 기준 = 개편 30 + §2.4 미변경 20.
  §1 의 "합계 50개"(개편 30 + Tech Notes 20)와 숫자만 같고 뜻이 다르다)

Search Console 작업 전 아래 항목을 다시 확인한다.

아래는 2026-08-14 11:15~11:40 KST 에 실제 live 응답으로 확인한 결과다.

- [x] GitHub Pages 배포가 기준 변경 `f300f26`을 포함한다.
      사이트 저장소 HEAD `ffb3c23`(6종 앱 한·영 기술 노트 추가), `f300f26`은 그 조상. working tree clean.
- [x] 옛 URL의 `noindex` 제거와 ytdl `lastmod` 정정 후속 commit을 기록한다: **`d6e04f0`**.
      ytdl `lastmod`는 `ffb3c23`에 이미 반영돼 있었고(아래 sitemap 항목), `noindex` 제거가 `d6e04f0`이다.
- [x] GitHub Pages live 배포가 기록한 후속 commit까지 반영한다.
      push 후 약 25초 만에 14개 전부 반영을 확인했다(2026-08-14 11:46 KST).
- [x] 새 URL 또는 이동 후 canonical URL 44개가 모두 `200`이다. — 44/44 `200`.
- [x] 옛 제품 URL 14개가 각각 대응하는 새 URL 하나로 직접 이동하며 `noindex`가 없다. — 14/14 충족.
- [x] 새 페이지에 `noindex`가 없다. — 44개 전부 없음.
- [x] 새 페이지의 canonical과 `hreflang`이 `/apps/`, `/manual/`, `/tech-notes/` 구조를 사용한다.
      44/44 self canonical 일치, 44/44 `hreflang` 2개 이상.
- [x] `robots.txt`가 `sitemap.xml`을 계속 가리킨다. — `Sitemap: https://droidactor.github.io/sitemap.xml`.
- [x] Google 소유권 확인 파일 `googlec8773d84a9d25688.html`을 삭제하지 않았다. — `200`.

## 4. Search Console에서 수행할 작업

### 4.1 속성

- [x] 기존 URL 접두어 속성 `https://droidactor.github.io/`를 연다. — 2026-08-14 수행.
- [x] 소유권이 계속 확인됨인지 본다. — 속성이 정상 열리고 URL 검사·색인 요청이 모두 수락됐다.
- [x] 새 속성을 만들지 않는다. — 만들지 않았다.
- [x] 주소 변경 도구를 실행하지 않는다. — 실행하지 않았다.

### 4.2 Sitemap

Google은 URL 이동 후 새 canonical URL을 담은 sitemap을 제출하라고 권장하며, 많은 새 URL의 crawl 요청에는
개별 URL 검사보다 sitemap이 적합하다고 안내한다.

- [x] `https://droidactor.github.io/sitemap.xml`의 실제 내용이 64 URL인지 확인한다.
      2026-08-14 실측: `200`, `Content-Type: application/xml`, BOM 없음, well-formed,
      root `urlset` + `xmlns=http://www.sitemaps.org/schemas/sitemap/0.9`, `<loc>` 64개.
      Googlebot UA 로도 `200`.
- [x] sitemap에는 옛 제품 URL 14개가 없고 새 canonical URL만 있는지 확인한다. — 옛 URL 0건.
- [x] 중요한 내용·구조·link가 바뀐 모든 URL의 `lastmod`가 실제 최종 변경일인지 양방향으로 확인한다.
      **실측: 64개 전부 `2026-08-14` 단일 값이다.** 이번 배포로 전역 탐색 링크가 모두 바뀌었으므로
      과다 표기는 아니나, 앞으로 부분 변경 때 같은 방식으로 전량 갱신하면 신호가 무뎌진다.

      **위 `[x]` 는 2026-08-14 시점 기록이다. 그 뒤 8-15·8-16 배포에서 실제로 신호가 무뎌졌고,
      2026-08-17 에 26건을 정정했다(§10.1).** 우려했던 일이 그대로 일어난 것이므로 이 항목은
      "한 번 끝낸 점검" 이 아니라 **배포마다 반복하는 점검**으로 취급한다.

      **그 반복이 2026-08-18 에 또 적중했다(§11.1).** 8-17 의 26건 정정은 `9a397f5` 로 배포됐고,
      8-18 에 `lastmod` 10건과 `dateModified` 20건을 고쳤다. **원인은 두 갈래이고 섞으면 안 된다** —
      `lastmod` 10건과 블로그 `dateModified` 10건은 `9a397f5` 가 새로 만든 어긋남이지만, 나머지
      `dateModified` 10건(매뉴얼 4 + Tech Notes 6)은 `a795df6`·`842eb3d`·`ec0f0cf` 때부터 있던
      어긋남이다. **§10.1 이 sitemap `lastmod` 만 고치고 짝이 되는 페이지 `dateModified` 를 손대지
      않아 남은 것**이고 `9a397f5` 는 그 반쪽을 배포해 드러냈을 뿐이다. 그래서 규칙을 하나 더 둔다 —
      **`lastmod` 를 고칠 때는 같은 URL 의 페이지 `dateModified`·화면 표시 날짜를 짝으로 함께 본다.**
      그 시점의 분포는
      `2026-08-14` 32 + `2026-08-15` 8 + `2026-08-16` 8 + `2026-08-18` 22 = 70 이었다.
      대조는 sitemap `lastmod` ↔ **그 파일의 마지막 "본문 변경" 배포일**로 한다 — 날짜 필드만 고친
      메타데이터 커밋은 콘텐츠 변경이 아니므로 날짜를 앞으로 당기지 않는다(§11.1).

      **세 번째 적중이 2026-08-19 에 나왔다(§12).** 커밋 `a806fbd` 가 홈 2개의 본문을 바꿨는데
      `lastmod` 가 `2026-08-18` 로 남아 있어 `2026-08-19` 로 고쳤다. **이로써 이 점검은 8-17·8-18·
      8-19 세 배포 연속으로 적중했다** — 예외적 사고가 아니라 배포 절차에 빠져 있는 단계라는 뜻이다.
      현재 분포는 `2026-08-14` 32 + `2026-08-15` 8 + `2026-08-16` 8 + `2026-08-18` 20 +
      `2026-08-19` 2 = 70 이다. (분포 수치는 배포마다 낡는다. 절 번호를 박으면 절이 늘 때마다 이
      문장도 고쳐야 하므로 — §6 8-15 절이 세운 것과 같은 이유로 — **최신값은 언제나 §6 의 가장
      마지막 날짜 절과 가장 마지막 배포 절에서 본다.** 앞선 배포 절에 적힌 분포는 그 시점의
      기록이다.)
- [x] `/apps/yt-downloader/`, `/ko/apps/yt-downloader/`를 포함해 이번에 전역 탐색 링크가 바뀐 URL의
      `lastmod`가 실제 변경일 `2026-08-14`인지 확인하고 배포한다. — 두 URL 모두 `2026-08-14`.
- [x] Search Console의 기존 sitemap 행을 **삭제하지 않는다.** 삭제하면 이전 처리 이력만 잃는다.
      삭제하지 않았다.
- [x] 기존 행의 상태·마지막으로 읽은 날짜·발견된 페이지 수를 기록한다.

      **2026-08-14 11:40 KST 기록 — 행이 1개뿐이다.**

      | Sitemap | 유형 | 제출 | 마지막으로 읽은 날짜 | 상태 | 발견된 페이지 |
      |---|---|---|---|---|---|
      | `/sitemap.xml` | 알 수 없음 | 2026-08-13 | (없음) | **가져올 수 없음** | 0 |

      마지막으로 읽은 날짜가 비어 있다 = Google이 아직 한 번도 성공적으로 가져가지 못했다.
      단 위 실측대로 sitemap·robots·Content-Type·Googlebot 접근은 전부 정상이므로 사이트 쪽
      결함은 확인되지 않으며, 제출 다음날의 미수집 상태로 본다.

      **2026-08-15 재확인 — 목록 행은 그대로이고, 세부 화면에서 위 해석이 정정됐다.**

      | 항목 | 목록 화면 | 세부 화면(`/sitemap.xml` 행 클릭) |
      |---|---|---|
      | 마지막으로 읽은 날짜 | (없음) | **2026-08-13** |
      | 상태 | 가져올 수 없음 | 사이트맵을 읽을 수 없음 |
      | 발견된 페이지 | 0 | 0 |

      목록 화면의 빈칸은 "한 번도 시도하지 않았다" 가 아니라 **성공한 읽기가 없다**는 뜻이다.
      세부 화면이 보여주듯 Google은 제출 당일인 2026-08-13에 한 번 읽기를 시도해 실패했고,
      2026-08-14·15에는 재시도 흔적이 없다. 그때의 실패가 당시(2026-08-15 실측 `200` +
      `application/xml` + well-formed + `<loc>` 66개) sitemap 의 결함을 뜻하지는 않는다.
      (최신 실측은 아래 8-19 문단에 있다.)

      **2026-08-19 정정 — 이 실패를 "개편 배포 전후의 혼란" 으로 설명하던 서술을 지웠다.** 시점이
      맞지 않는다. `f300f26` 은 **2026-08-14 09:21 KST** 로 제출 하루 뒤이고, 8-13 에 Google 이
      읽으려 한 것은 개편 이전의 34 URL sitemap 이다. 그 파일은 `c48305c`(8-08) 이래 `<loc>` 34개로
      구조가 그대로였고, 당일 sitemap 을 손댄 두 커밋(`9fcb906` 08:29, `19a9493` 08:41)이 바꾼 것도
      각각 `lastmod` 두 줄뿐이다. 즉 **오래 안정돼
      있던 파일에서 일어난 실패**이므로 원인은 사이트가 아니라 Google 쪽 일시 오류나 재시도
      백오프로 본다. 결론(현재 sitemap 에 결함이 없다)은 그대로지만 근거가 바뀌므로 **"개편이
      끝났으니 곧 풀린다" 는 기대는 성립하지 않는다.**

      **2026-08-17 재확인 — 목록 화면 값이 8-15 와 같다.**

      | 항목 | 목록 화면 | 세부 화면 |
      |---|---|---|
      | 제출 | 2026. 8. 13. | (미확인) |
      | 마지막으로 읽은 날짜 | (없음) | (미확인) |
      | 상태 | 가져올 수 없음 | (미확인) |
      | 발견된 페이지 | 0 | (미확인) |

      **세부 화면은 아직 열어 보지 않았다.** 8-15 가 힘들여 정정한 교훈이 바로 "목록의 빈칸을
      단독으로 해석하지 말라" 이므로, 여기서 "마지막 읽기는 8-13 그대로" 라고 단정하지 않는다.
      8-13 이후 재시도가 있었는지는 세부 화면을 열어야 알 수 있고, 그 확인은 **8-20 판정 전에
      반드시 한 번 수행한다.** 목록 값만으로 지금 말할 수 있는 것은 **성공한 읽기가 아직 없다**는
      사실 하나뿐이며, 그것만으로도 재제출 판정일 2026-08-20 은 그대로 유지된다.

      **2026-08-19 live 재진단 — 사이트 쪽 원인은 실측으로 배제된다.** 일반 UA·Googlebot UA 둘 다
      `200`, `Content-Type: application/xml`, BOM 없음(`3c 3f 78`), XML well-formed,
      root `urlset` + 정규 xmlns, `<loc>` 70개(중복 0, 전부 https 절대 URL), `http://` 접근은 301
      1회로 https 도달(사슬 1단계), `robots.txt` 는 `200` + `Allow: /` + `Sitemap:` 정확.
      **따라서 "가져올 수 없음" 을 사이트가 만들고 있지 않다.** 남은 설명은 재시도 백오프이며,
      이 속성은 그 조건에 정확히 부합한다 — 외부 링크 0, 내부 링크 그래프 0, 색인 22 로 크롤 예산이
      작다(§5, §6). 사이트 접근성 문제가 아니라는 방증도 있다: 8-14 11:47 의 `/tech-notes/` 색인
      요청은 3분 뒤 실제 크롤을 유발했다(수동 요청은 크롤 예산 큐를 우회하므로 백오프 가설의
      반증은 아니고, 접근 경로가 살아 있다는 근거다). **막혀 있는 것은 sitemap 경로 하나뿐이다.**

      같은 기간에 Googlebot 이 사이트를 크롤하고는 있다(아래 §6 2026-08-17 의 색인 22개). 따라서
      robots·접근성 문제로 보지 않는다.

- [ ] Tech Notes 배포 후 마지막으로 읽은 날짜가 2026-08-16 이후이고 발견된 페이지가 70이면 추가
      제출하지 않는다. — 2026-08-17 현재 **성공한 읽기가 없어** 판정 불가. 이월. (세부 화면을 열지
      않았으므로 "마지막 읽기 = 8-13" 으로 단정하지 않는다 — 같은 절이 8-15 에 정정한 해석이다.)
      (기준값이 8-14·64 에서 8-16·70 으로 바뀐 이유는 §10 의 4개가 8-16 에 더 배포됐기 때문이다.)
- [ ] 7일 뒤에도 개편 이전 sitemap 내용(34 URL)을 기준으로 머물거나 `가져올 수 없음`이면, 기존 행을 삭제하지 않은 채
      같은 `sitemap.xml`을 한 번 제출한다.
      **판정 기준일 = 2026-08-20.** 그날에도 `가져올 수 없음`이면 그때 1회 재제출한다.
      2026-08-14·15·17 에는 규칙대로 재제출하지 않았다.
- [ ] 이후 반복 제출하지 않고 상태 변화를 기다린다.

**sitemap 미수집이 실제로 발견 경로를 막고 있다는 실측(2026-08-15).** 새 URL을 URL 검사하면
`검색 > Sitemaps` 칸이 **`감지된 참조 사이트맵이 없습니다`** 로 나오고, 미발견 URL은 `참조 페이지`도
`감지된 페이지 없음`이다. 즉 현재 새 URL의 유일한 발견 경로는 **이미 크롤된 페이지의 내부 링크**와
**수동 색인 생성 요청** 둘뿐이다. 실제로 그 경로는 작동하고 있다 — 아래 `/ko/tech-notes/` 참조.

정상 목표:

- 상태: `성공`
- 발견된 페이지: **`70`** (2026-08-16 배포 기준. 8-14 시점 목표였던 64 는 그 뒤 §9 의 2개와 §10 의
  4개가 더해져 갱신됐다.)
- sitemap에 포함된 URL: 새 canonical URL만 표시

근거:

- [Google: Sitemap 작성·제출](https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap)
- [Google: URL 검사 및 다수 URL 재색인](https://support.google.com/webmasters/answer/9012289)

### 4.3 URL 검사 → 색인 생성 요청

새 URL을 한꺼번에 수동 요청하지 않는다. Sitemap이 기본 경로이고, URL 검사는 중요한 URL의 발견을
앞당기거나 비색인 원인을 진단하는 보조 수단이다. Google은 속성별 일일 요청 제한이 있다고 명시한다.

이 사이트에서 2026-08-10~11에 확인한 실행 규칙을 그대로 적용한다.

- KST 09:00 이후 시작한다.
- 하루 10개를 기준으로 진행한다.
- 할당량 초과 메시지가 나오면 그날은 즉시 중단한다.
- 같은 URL을 반복 요청하지 않는다.
- 요청 전 반드시 `실제 URL 테스트`를 통과시킨다.

**2026-08-14 에 이 "하루 10개" 가 실제 한도임이 확인됐다.** 우선순위 0의 10개를 요청한 뒤 같은 날
Tech Notes 허브 2개를 이어서 요청했고, **12번째(`/ko/tech-notes/`)에서 "할당량 초과 — 일일 할당량을
초과하여 이 요청을 처리할 수 없습니다. 내일 다시 제출해 주세요." 가 떴다.** 11개까지는 통과했다.
하루 10개는 여유 있는 목표치가 아니라 한도 바로 아래 값이므로, **10개를 채웠으면 그날은 끝낸다.**

**2026-08-17 에 확인한 GSC 화면 동작 3가지.** 8-14 에 사람이 손으로 할 때는 드러나지 않았던 것들이고,
셋 다 "요청이 실패한 것처럼 보이지만 실제로는 아닌" 오판을 만든다.

1. **`색인 생성 요청` 버튼이 실시간 테스트를 자동으로 수행한다.** 누르면 `실제 URL의 색인을 생성할 수
   있는지 테스트 중(1~2분 걸릴 수 있습니다)` → `요청 제출 중` → `색인 생성 요청됨` 순으로 진행된다.
   따라서 §4.3 의 "요청 전 실제 URL 테스트 통과" 규칙은 이 경로로 충족된다. 반대로 **`실제 URL 테스트`
   버튼을 먼저 눌러 그 탭에서 요청하면 흐름이 꼬여 모달이 멈춘다**(실측 5분 이상 `데이터 가져오는 중`
   에서 정지). 요청은 결과 화면에서 바로 누르는 편이 안전하다.
2. **성공 대화상자 위에 `Google 색인에서 데이터 가져오는 중` 모달이 겹쳐 뜬다.** 요청 직후 GSC 가
   결과를 재조회하기 때문이다. 위에 덮인 것만 보고 "요청이 안 끝났다" 고 읽으면 오판이다 — 아래 깔린
   `색인 생성 요청됨` 을 함께 확인한다.
3. **검사창에 이력이 쌓이면 입력 즉시 자동완성 목록이 열리고 `Enter` 가 그 목록에 소비된다.** 조회가
   시작되지 않는데 화면은 직전 URL 의 결과를 그대로 보여주므로, **결과 카드에 지금 검사한 URL 이
   찍혔는지 확인하기 전에는 그 판정을 그 URL 의 것으로 믿지 않는다.** 목록이 열려 있으면 항목을
   직접 클릭한다.

**요청 성공 판정에서 속기 쉬운 지점 — 화면의 "색인 생성 요청됨" 은 그 자체로 성공 근거가 아니다.**
GSC 는 버튼을 누른 직후 성공 대화상자를 먼저 띄우고, 서버가 할당량을 확인해 거절하면 그 대화상자를
닫은 **뒤에** "할당량 초과" 를 새로 띄운다. 결과 카드에 남는 인라인 `✓ 색인 생성 요청됨` 표시도
거절된 요청에 그대로 남는다. 그래서 판정은 **성공 대화상자를 닫은 다음 초과 대화상자가 뒤따르는지까지
확인**해야 한다.

#### 우선순위 0 — 즉시 요청: 허브와 출시 앱의 새 제품 URL, 10개

**2026-08-14 11:15~11:38 KST 에 10개 전부 완료했다.** 각 URL은 `URL 검사` → `실제 URL 테스트`
(전부 "URL을 Google에 등록할 수 있음") → `색인 생성 요청`(전부 "색인 생성 요청됨 — URL이 우선순위
크롤링 대기열에 추가되었습니다") 순으로 처리했다. 할당량 초과 메시지는 나오지 않았다.
검사 시점의 GOOGLE 색인 탭은 모두 "URL이 Google에 등록되어 있지 않음 / 아직 알려지지 않은 URL"이었다
— 신규 경로이므로 예상된 값이다.

- [x] `https://droidactor.github.io/apps/`
- [x] `https://droidactor.github.io/ko/apps/`
- [x] `https://droidactor.github.io/manual/`
- [x] `https://droidactor.github.io/ko/manual/`
- [x] `https://droidactor.github.io/apps/bt-keyboard/`
- [x] `https://droidactor.github.io/ko/apps/bt-keyboard/`
- [x] `https://droidactor.github.io/apps/wifi-scout/`
- [x] `https://droidactor.github.io/ko/apps/wifi-scout/`
- [x] `https://droidactor.github.io/apps/lgtv/`
- [x] `https://droidactor.github.io/ko/apps/lgtv/`

**같은 URL을 다시 요청하지 않는다.** 다음 요청일은 Tech Notes 허브 2개가 대상이다(아래 별도 묶음).

#### 우선순위 1 — 조건부 요청: 매뉴얼 3종과 나머지 Bluetooth 제품 URL, 10개

먼저 sitemap에 맡긴다. 7~14일 뒤에도 URL Inspection에서 미발견 또는 비색인이면 제외 사유와 live test를
확인하고, 기술 문제를 고친 뒤 필요한 URL만 요청한다.

**우선순위 1·2 를 가른 기준은 "출시 앱 먼저" 였는데 그 기준은 2026-08-14 오후에 소멸했다** —
`bt-ppt`·`bt-mouse`·`ssh-scout` 가 프로덕션에 올라 6종이 모두 출시 상태가 됐고, 미출시는
`yt-downloader`(우선순위 2) 하나뿐이다. 위 우선순위 0 의 "출시 앱" 은 8-14 오전 시점 기록이므로
그대로 둔다. 실제 요청일에는 두 묶음의 순서를 출시 여부가 아니라 **색인 미도달 여부**로 다시 정한다.

**2026-08-15 표본 스캔 — 3개 전부 미발견이다.** URL 검사는 색인 생성 요청과 달리 일일 할당량을
소모하지 않으므로 요청 대상 선별에 자유롭게 쓴다.

| URL | 판정 | Sitemaps | 참조 페이지 |
|---|---|---|---|
| `/manual/bt-keyboard/` | URL이 Google에 등록되어 있지 않음 | 감지된 참조 사이트맵 없음 | 감지된 페이지 없음 |
| `/ko/apps/bt-ppt/` | URL이 Google에 등록되어 있지 않음 | 감지된 참조 사이트맵 없음 | 감지된 페이지 없음 |
| `/apps/bt-mouse/` | URL이 Google에 등록되어 있지 않음 | 감지된 참조 사이트맵 없음 | 감지된 페이지 없음 |

`/apps/bt-ppt/` 도 같은 값이며 "Google에는 아직 알려지지 않은 URL" 로 표시된다.

**2026-08-17 전수 스캔 — 18개 전부 미색인이다.** 표본이 아니라 우선순위 1의 10개 + bt-keyboard
상세 노트 6개 + 그 부모 허브 2개를 모두 검사했다. 18/18 이 `URL이 Google에 등록되어 있지 않음` +
`참조 페이지: 감지된 페이지 없음` + `최근 크롤링: 해당사항 없음` 이다.

| 묶음 | 대상 | 결과 |
|---|---|---|
| 우선순위 1 | 매뉴얼 6 + `(ko/)apps/{bt-ppt, bt-mouse}` 4 | 10/10 미색인 |
| bt-keyboard 상세 노트 | §9 2개 + §10 4개 | 6/6 미색인 |
| bt-keyboard Tech Notes 허브 | `(ko/)tech-notes/bt-keyboard/` | 2/2 미색인 |

**허브 2개가 미색인이라는 사실이 상세 노트의 처지를 설명한다.** 지금까지 상세 노트를 후순위로 둔
근거는 "허브가 색인되면 내부 링크로 딸려 발견된다" 였는데, 그 허브 자체가 색인되지 않았다.
현재 링크 사슬은 `/tech-notes/`(색인됨) → `/tech-notes/bt-keyboard/`(**미색인**) → 상세(미색인)
로 중간이 끊겨 있다. 상세 노트가 스스로 발견될 경로는 지금 없다.

**2026-08-17 에 이 10개를 전부 요청했다.** 원래 계획일은 8-21~28 이었으나 앞당겼다 — 판단 근거는
아래 §6 의 2026-08-17 절에 적었다. 10/10 이 `색인 생성 요청됨 — URL이 우선순위 크롤링 대기열에
추가되었습니다` 이고 할당량 초과는 나오지 않았다. 오늘 예산 10개를 정확히 소진했다.

- [x] `https://droidactor.github.io/manual/bt-keyboard/`
- [x] `https://droidactor.github.io/ko/manual/bt-keyboard/`
- [x] `https://droidactor.github.io/manual/wifi-scout/`
- [x] `https://droidactor.github.io/ko/manual/wifi-scout/`
- [x] `https://droidactor.github.io/manual/lgtv/`
- [x] `https://droidactor.github.io/ko/manual/lgtv/`
- [x] `https://droidactor.github.io/apps/bt-ppt/`
- [x] `https://droidactor.github.io/ko/apps/bt-ppt/`
- [x] `https://droidactor.github.io/apps/bt-mouse/`
- [x] `https://droidactor.github.io/ko/apps/bt-mouse/`

**같은 URL을 다시 요청하지 않는다.** 다음 요청일의 대상은 우선순위 2(§4.3)와 Tech Notes 허브 12개다.

#### 우선순위 2 — 조건부 요청: 나머지 제품·매뉴얼 URL, 10개

우선순위 1과 같은 기준을 적용한다. 이미 발견·crawl됐거나 정상적으로 색인 대기 중인 URL은 요청하지 않는다.

- [ ] `https://droidactor.github.io/apps/ssh-scout/`
- [ ] `https://droidactor.github.io/ko/apps/ssh-scout/`
- [ ] `https://droidactor.github.io/apps/yt-downloader/`
- [ ] `https://droidactor.github.io/ko/apps/yt-downloader/`
- [ ] `https://droidactor.github.io/manual/bt-ppt/`
- [ ] `https://droidactor.github.io/ko/manual/bt-ppt/`
- [ ] `https://droidactor.github.io/manual/bt-mouse/`
- [ ] `https://droidactor.github.io/ko/manual/bt-mouse/`
- [ ] `https://droidactor.github.io/manual/ssh-scout/`
- [ ] `https://droidactor.github.io/ko/manual/ssh-scout/`

#### Tech Notes — 별도 요청 묶음: 허브 2개 우선, 상세 12개 조건부

Tech Notes 배포 다음 요청일에는 허브 2개를 실제 URL 테스트한 뒤 요청한다. 상세 문서는 먼저 sitemap과
앱·매뉴얼·Tech Notes 허브의 내부 링크에 맡기고, 7~14일 뒤에도 미발견 또는 비색인이면 원인을 확인한 뒤
필요한 URL만 선별 요청한다.

**2026-08-14 에 이 2개를 우선순위 0의 10개와 같은 날 이어서 요청했다(원래 계획은 "다음 요청일"이었다).
그 결과 하루 12개가 되어 마지막 1개가 일일 할당량에 걸렸다.**

- [x] `https://droidactor.github.io/tech-notes/` — 우선 요청
      2026-08-14 11:47 KST 요청 접수(11번째). 실시간 테스트 통과.
- [x] `https://droidactor.github.io/ko/tech-notes/` — 우선 요청 **(요청 없이 종결. 같은 묶음의 위
      항목 `[x]` 가 "요청 접수됨" 인 것과 뜻이 다르다)**
      2026-08-14 11:49 KST 요청 실패 — "할당량 초과 / 내일 다시 제출해 주세요"(12번째).
      실시간 테스트는 "URL을 Google에 등록할 수 있음" 으로 통과했으므로 페이지 문제가 아니었다.
      **2026-08-15 에 재요청하려고 URL 검사한 결과 이미 `URL이 Google에 등록되어 있음`(색인 완료)
      이어서 색인 생성 요청 없이 종결했다.** 세부값:

      | 항목 | 값 |
      |---|---|
      | Sitemaps | 감지된 참조 사이트맵이 없습니다 |
      | 참조 페이지 | `https://droidactor.github.io/tech-notes/` |
      | 최근 크롤링 | 2026-08-14 11:50:38 |
      | 크롤링에 사용된 에이전트 | Googlebot 스마트폰 |
      | 크롤링 허용 / 페이지 가져오기 / 색인 생성 허용 | 예 / 성공 / 예 |
      | 사용자 선언 표준 URL | `https://droidactor.github.io/ko/tech-notes/` |
      | Google에서 선택한 표준 URL | 검사된 URL (self canonical 일치) |

      **어제의 할당량 초과는 결과적으로 손실이 아니었다.** 8-14 11:47 에 통과한 `/tech-notes/`
      요청이 3분 뒤 크롤을 유발했고, Googlebot이 그 페이지의 `hreflang`·내부 링크를 따라
      `/ko/tech-notes/` 까지 스스로 발견·색인했다. 참조 페이지 칸이 그 경로를 그대로 보여준다.
      **같은 URL을 다시 요청하지 않는다** — 이미 색인된 URL의 요청은 할당량만 소모한다.
- [ ] `https://droidactor.github.io/tech-notes/bt-keyboard/`
- [ ] `https://droidactor.github.io/ko/tech-notes/bt-keyboard/`
- [ ] `https://droidactor.github.io/tech-notes/bt-ppt/`
- [ ] `https://droidactor.github.io/ko/tech-notes/bt-ppt/`
- [ ] `https://droidactor.github.io/tech-notes/bt-mouse/`
- [ ] `https://droidactor.github.io/ko/tech-notes/bt-mouse/`
- [ ] `https://droidactor.github.io/tech-notes/wifi-scout/`
- [ ] `https://droidactor.github.io/ko/tech-notes/wifi-scout/`
- [ ] `https://droidactor.github.io/tech-notes/ssh-scout/`
- [ ] `https://droidactor.github.io/ko/tech-notes/ssh-scout/`
- [ ] `https://droidactor.github.io/tech-notes/lgtv/`
- [ ] `https://droidactor.github.io/ko/tech-notes/lgtv/`

**bt-keyboard 상세 노트 6개는 위 12개보다 후순위다.** §9 의 2개(Google TV HID, 8-14 배포)와 §10 의
4개(각인 드리프트·HID 세션 공유, 8-16 배포)를 말한다. 허브·앱별 Tech Notes 가 먼저 색인되면 그
내부 링크로 발견될 수 있으므로, 상세 노트를 수동 요청에 먼저 태우지 않는다. 실제 요청 순서는
요청일에 **색인 미도달 여부**로 다시 정한다(§4.3 우선순위 1 의 같은 원칙).

수동 URL 검사 대상으로 선택한 URL에서 확인할 값 (아래는 우선순위 0의 10개에 대한 2026-08-14 결과):

- [x] Page fetch: 성공 — 실시간 테스트에서 10/10 "페이지 색인을 생성할 수 있음".
- [x] Crawl allowed: 예 — `robots.txt`가 `Allow: /`이고 실시간 테스트가 전부 통과했다.
- [x] Indexing allowed: 예 — 새 페이지 44개에 `noindex`가 없다(§3).
- [x] User-declared canonical: 검사한 새 URL과 동일 — 44/44 self canonical(§3).
- [x] 실제 URL 테스트: 성공 — 10/10 "URL을 Google에 등록할 수 있음".
- [x] 색인 요청 대상으로 선별한 URL만 `색인 생성 요청` 성공을 확인 — 10/10 "색인 생성 요청됨".

### 4.4 옛 URL 확인

옛 URL은 sitemap에 다시 넣거나 색인 생성 요청하지 않는다. Google이 기존 URL을 다시 crawl하면서 이동
신호를 읽도록 계속 제공한다.

- [x] 영문 대표 `/bt-keyboard/`를 URL 검사하여 새 `/apps/bt-keyboard/`로 이동하는지 확인한다.
- [x] 국문 대표 `/ko/bt-keyboard/`를 URL 검사하여 새 `/ko/apps/bt-keyboard/`로 이동하는지 확인한다.
- [x] 기존에 색인됐던 나머지 옛 제품 URL도 대응하는 새 URL로 1:1 연결되는지 표본 확인한다.
- [ ] 옛 URL에 대한 삭제 요청을 만들지 않는다.
- [ ] 옛 URL 호환 페이지를 최소 2027-08-14까지 삭제하지 않는다.

**2026-08-15 URL 검사 실측 — 옛 URL 4개(`/bt-keyboard/`, `/ko/bt-keyboard/`, `/wifi-scout/`,
`/ko/lgtv/`)가 전부 `URL이 Google에 등록되어 있음`(색인 유지) 상태다.** 아직 이동이 반영되지 않았고,
그것이 정상이다. 이유는 세부값이 설명한다 — 표본 `/ko/lgtv/`:

| 항목 | GSC 값 | live 실측(2026-08-15) |
|---|---|---|
| 최근 크롤링 | **2026-08-13 08:56:16** | — |
| 참조 페이지 | `/lgtv/`, `/ko/blog/control-lg-webos-tv-over-wifi/` | — |
| 사용자 선언 표준 URL | `https://droidactor.github.io/ko/lgtv/` (옛 URL 자신) | `https://droidactor.github.io/ko/apps/lgtv/` |
| Google에서 선택한 표준 URL | 검사된 URL | — |
| `meta refresh` | (크롤 시점에 없었음) | `0; url=/ko/apps/lgtv/` |

**GSC가 보여주는 canonical 은 2026-08-13 크롤 시점의 캐시이고, 이동 신호를 넣은 배포는 그 뒤인
2026-08-14 이다.** 같은 날 `/bt-keyboard/` 도 live 는 canonical `/apps/bt-keyboard/` +
`meta refresh 0; url=/apps/bt-keyboard/` 로 정확하다. 즉 사이트 쪽 신호는 갖춰졌고, 남은 것은
**Googlebot이 옛 URL 14개를 재크롤하는 일**뿐이다. 재크롤 전까지 GSC 값이 옛 상태로 남아 있는 것을
결함으로 읽지 않는다. 옛 URL에는 색인 생성 요청을 하지 않는다(§7).

URL 이동은 Googlebot이 옛 URL과 새 URL을 각각 crawl해야 URL 단위로 처리된다. Google 공식 문서는 redirect를
일반적으로 최소 1년 유지하라고 권장한다.

## 5. 외부 링크 갱신

내부 링크와 sitemap은 이미 새 URL로 바뀌었다. 외부에서 옛 제품 URL을 직접 가리키는 링크가 있으면 새
canonical URL로 바꾸면 redirect 의존도를 줄일 수 있다.

- [x] Search Console의 `링크` 보고서에서 옛 제품 URL로 들어오는 외부 링크를 확인한다.
      **2026-08-15 실측: 외부 링크 총 `0`개, 내부 링크 총 `0`개, 상위 링크된 페이지·상위 링크 사이트
      모두 `데이터 없음`.** 따라서 이 절에서 바꿔야 할 외부 링크는 현재 없다. 내부 링크까지 0인 것은
      GSC가 아직 이 사이트의 링크 그래프를 거의 수집하지 못했다는 뜻이며(색인된 페이지가 한 자릿수),
      sitemap 미수집·새 URL 미발견과 같은 원인을 공유한다. 링크 그래프는 크롤이 진행되면 채워진다.

      **2026-08-17 정정 — "색인된 페이지가 한 자릿수" 라는 근거가 무너졌다.** 같은 날 확인한
      Page indexing 보고서의 색인 수는 22 다(§6). 색인 22 인데 내부 링크 그래프가 0 이면 원인은
      "크롤이 부족해서" 가 아니라 다른 데 있다. 링크 보고서는 반영이 특히 느린 보고서이므로 일단
      그 지연으로 보되, **8-20 판정 때 §5 를 한 번 다시 읽어 여전히 0 인지 확인한다.**
- [x] 직접 수정 가능한 Blogger·Naver·GitHub README·프로필 링크가 있으면 `/apps/<app>/`로 바꾼다.
      **저장소 실측(2026-08-15): 배포되는 문서에는 옛 제품 URL 참조가 없다.** 유일한 적중은
      `doit.txt` 17~19행인데, **이 파일은 `.gitignore` 의 `/doit.txt` 로 애초에 배포되지 않는다**
      (2026-08-17 live 실측 `404`). 검색 영향은 0이므로 이 항목은 닫는다. 로컬 메모의 내용이
      개편 이전 구조를 설명하는 것은 검색과 무관한 별개 사안이다.
- [ ] Google Play Console의 스토어 등록정보가 제품 상세 URL을 직접 사용한다면 새 `/apps/<app>/`로 바꾼다.
- [ ] 개발자 웹사이트가 root `https://droidactor.github.io/`이면 변경하지 않는다.
- [ ] 개인정보 처리방침 URL `/#privacy-*`, `/ko/#privacy-*`는 변경하지 않는다.

## 6. 관찰 일정과 완료 조건

### 배포 직후 — 2026-08-14 완료

- [x] live `200`, redirect, canonical, sitemap 64개를 확인한다. (§3, §4.2)
- [x] Search Console sitemap의 현재 상태를 기록한다. — `가져올 수 없음` / 0 페이지 (§4.2)
- [x] 우선순위 0 URL 검사를 수행한다. — 10/10 색인 생성 요청 완료 (§4.3)

2026-08-14 에 처리 완료된 것: 우선순위 0 URL 10개 색인 요청, `/tech-notes/` 색인 요청,
옛 호환 페이지 14개 `noindex` 제거 배포(commit `d6e04f0`).

### 2026-08-15 — 확인 작업 완료, 색인 생성 요청은 0건

이날 예정돼 있던 "다음 작업 2건" 을 둘 다 처리했고, **일일 할당량 10개를 한 건도 쓰지 않았다.**

1. **`/ko/tech-notes/` 재요청 → 불필요로 종결.** URL 검사 결과 이미 색인돼 있었다. 8-14 에
   통과한 `/tech-notes/` 요청이 유발한 크롤이 내부 링크를 따라 국문판까지 도달했다 (§4.3).
2. **sitemap `가져올 수 없음` 미해소.** 세부 화면에서 마지막 읽기가 2026-08-13(실패)임을 확인했고,
   목록 화면의 빈칸 해석을 정정했다. 재제출 판정 기준일은 그대로 2026-08-20 (§4.2).

추가로 확인한 것:

- 옛 제품 URL 4개 표본 검사 — 전부 색인 유지, GSC 값은 8-13 크롤 캐시 (§4.4).
- 새 URL 표본 4개(`/manual/bt-keyboard/`, `/apps/bt-ppt/`, `/ko/apps/bt-ppt/`, `/apps/bt-mouse/`)
  — 전부 미발견 (§4.3 우선순위 1).
- Google TV HID 기술 노트 한·영 2개 live 확인, sitemap `<loc>` 66개 (§9).
- 링크 보고서 — 외부 링크 0, 내부 링크 0, 상위 링크된 페이지·사이트 모두 데이터 없음 (§5).

**Page indexing 보고서 현재값(최종 업데이트 2026-08-07 — 이번 개편 이전 데이터다):**

| 항목 | 값 |
|---|---|
| 색인 생성됨 | 6 |
| 색인이 생성되지 않음 | 3 (사유 1종) |
| 사유 | `크롤링됨 - 현재 색인이 생성되지 않음` / 소스 `Google 시스템` / 3 페이지 |

이 수치는 8-14 개편과 8-14~15 크롤을 아직 반영하지 않았다. §6 "7일 후" 의 Page indexing 항목은
보고서 최종 업데이트 날짜가 2026-08-14 이후로 넘어간 뒤에 다시 읽는다.

**다음 작업 → 최신 목록은 §6 의 가장 마지막 날짜 절에만 둔다.** 같은 목록을 날짜 절마다 복제하면
계획이 바뀔 때 한쪽만 고쳐져 두 판본이 어긋난다(실제로 이 절과 8-17 절의 문구가 갈리기 시작했다).
날짜를 박아 두면 절이 하나 늘 때마다 이 문장도 고쳐야 하므로 "가장 마지막 절" 로 적는다.

### 2026-08-17 — 우선순위 1의 10개 색인 요청 완료, 예산 소진

**색인 생성 요청 10건을 접수했다**(§4.3 우선순위 1 전량). 원래 계획일은 8-21~28 이었으나 앞당겼고,
그 판단 근거는 이 절 5번에 적었다. 함께 Page indexing 보고서의 색인 대상 전량을 처음으로 확보했다.

1. **sitemap 목록 화면 값이 8-15 와 같다.** `가져올 수 없음` / 발견 0. **세부 화면은 열지 않았으므로
   "마지막 읽기가 8-13 그대로" 라고 단정하지 않는다** — 8-20 판정 전에 세부 화면을 확인한다 (§4.2).
2. **Page indexing 보고서가 2026-08-10 자로 갱신됐다.** 8-15 확인 때의 최종 업데이트는 8-07 이었다.

   | 항목 | 2026-08-15 확인(8-07 자) | 2026-08-17 확인(8-10 자) |
   |---|---|---|
   | 색인 생성됨 | 6 | **22** |
   | 색인이 생성되지 않음 | 3 | **5** |
   | 사유 | `크롤링됨 - 현재 색인이 생성되지 않음` 1종 | 같음(1종, 소스 `Google 시스템`, 유효성 검사 `시작되지 않음`) |

3. **색인된 22개의 전량 목록을 CSV 로 내려받아 확인했다**(보고서 → `색인이 생성된 페이지에 대한
   데이터 보기` → `내보내기` → `CSV 다운로드`). 결론은 하나다 — **개편 이후의 새 구조 URL
   (`/apps/`, `/manual/`, `/tech-notes/`)은 22개 중 0개다.**

   | 분류 | 개수 | 최종 크롤링 |
   |---|---|---|
   | 홈 `/` | 1 | 2026-08-07 |
   | 블로그 글(한·영) | 12 | 2026-08-10 ~ 08-11 |
   | 옛 제품 URL | 9 (`/bt-keyboard/`, `/bt-mouse/`, `/wifi-scout/`, `/ssh-scout/`, `/lgtv/`, `/ko/bt-keyboard/`, `/ko/bt-mouse/`, `/ko/wifi-scout/`, `/ko/ssh-scout/`) | 2026-08-08 ~ 08-11 |

   **이 0개를 실패 신호로 읽지 않는다.** 이 보고서의 데이터 기준일은 2026-08-10 이고 목록의 최종
   크롤링도 8-11 이 최신인데, 개편 배포와 색인 요청은 8-14 다. 즉 **보고서가 아직 개편 이후 기간에
   도달하지 않았다.** 실제로 8-15 에 URL 검사(실시간)로 확인한 `/ko/tech-notes/` 는 이미 색인 완료였고
   그 URL 역시 이 CSV 에는 없다. 보고서와 URL 검사의 시차를 혼동하지 않는다.
4. **§10 의 새 URL 4개 live 검증 완료**, sitemap `<loc>` 70개 확인, `lastmod` 26건 정정(§10.1).
5. **우선순위 1의 10개를 요청했다 — 계획일(8-21~28)보다 앞당긴 근거.**

   - sitemap 이 제출 후 나흘째 한 번도 성공 수집되지 않았다. "먼저 sitemap 에 맡긴다" 는 §4.3 의
     대기 전제가 성립하지 않는다.
   - 위 3번대로 **새 구조 URL 중 색인된 것이 하나도 없고**, 이날 전수 검사한 18개도 전부 미색인에
     `참조 페이지: 감지된 페이지 없음` 이다. 내부 링크를 통한 발견도 일어나지 않고 있다.
   - 일일 할당량 10개는 **이월되지 않는다.** 8-15·16 의 20개는 이미 소멸했다. 기다림의 비용이 0 이 아니다.
   - 색인 요청과 sitemap 수집은 GSC 에서 독립된 경로다. 8-14 에 sitemap 이 실패 상태인 채로 11건이
     접수됐고 `/tech-notes/` 는 3분 뒤 실제로 크롤됐다. **오늘 요청이 8-20 재제출 판정을 오염시키지
     않는다** — 그 판정 기준은 sitemap 행의 상태·읽은 날짜이지 요청 이력이 아니다.

**다음 작업 → §6 의 가장 마지막 날짜 절에 있다.** 이 절의 목록은 그 뒤 갱신됐으므로 여기서 지웠다
(같은 목록을 날짜 절마다 복제하지 않는다는 §6 8-15 절의 규칙). 8-17 이 남긴 6개 항목 중 2번
(`lastmod` 26건 배포)은 8-18 에 완료됐고, 나머지는 8-18 절의 목록이 이어받았다.

### 2026-08-18 — 8-18 배포 검증과 날짜 신호 정정, 색인 요청 0건

이날은 사이트 쪽 작업만 했다. **색인 생성 요청은 하지 않았고 일일 할당량 10개를 한 건도 쓰지 않았다** —
GSC 접속이 필요한 항목은 아래 다음 작업 1~3번으로 남긴다.

1. **8-17 의 다음 작업 2번(§10.1 `lastmod` 26건 배포)이 완료됐다.** 별건 작업 커밋
   `9a397f5`(2026-08-18 18:05 KST, "블로그 앱 카드와 스크린샷을 Google Play 링크로 전환")가 그
   미커밋 변경을 함께 담아 배포했다. live `sitemap.xml` 이 저장소 파일과 완전히 동일함을 확인했다.
   **8-20 재제출의 선결 조건이 해소됐다.**
2. **같은 커밋이 기존 22개 URL 의 본문을 바꿨고 새 URL 은 없다.** sitemap `<loc>` 수는 70 그대로다.
   범위와 검증은 §11 에 적었다.
3. **live 전수 검증 — 70/70 정상.** sitemap 의 70개 URL 전부 `200` + self canonical 일치 +
   `noindex` 없음 + `hreflang` 2개 이상. 옛 제품 URL 14개도 14/14 가 `200` +
   `meta refresh 0; url=<대응 새 URL>` + 새 URL canonical + `noindex` 없음이다.
4. **어긋남 34건을 찾아 고쳤다(§11.1)** — `lastmod` 10 + `dateModified` 20 + 매뉴얼 화면 표기 4.
   §4.2 가 "배포마다 반복하는 점검" 으로 격상한 항목이 그 배포에서 실제로 또 걸렸다. 정정 작업은
   8-18 에 했고 **배포는 2026-08-19 에 이 정정 커밋으로 했다**(§11.1 머리말). 매뉴얼 화면 표기 4건은
   **diff 검열이 잡아낸 것**이다 — 구조화 데이터만 고치고 화면
   표기를 두면 Google 이 보이는 날짜를 채택해 정정이 무효화된다(§11.1 B-2).
5. **`bt-mouse` 스토어 링크 22곳이 현재 Google Play 에서 `404` 다(§11.2).** 배포 커밋이 재등록 예정
   패키지명 `com.droidactor.bt_mouse2` 를 게시 전에 선반영했기 때문이다. 사이트 쪽 결함은 아니지만
   검색·사용자 양쪽에 영향이 있어 별도 항목으로 남긴다.

**다음 작업 → §6 의 가장 마지막 날짜 절에 있다.** 이 절의 목록은 그 뒤 갱신됐으므로 여기서 지웠다
(같은 목록을 날짜 절마다 복제하지 않는다는 §6 8-15 절의 규칙). 8-18 이 남긴 9개 항목 중 1번
(§11.1 정정 배포)은 8-19 에 완료됐고, 나머지는 8-19 절의 목록이 이어받았다.

### 2026-08-19 — 처리방침 앵커 배포와 `lastmod` 정정, 색인 요청 0건

이날도 사이트 쪽 작업만 했다. **색인 생성 요청은 하지 않았고 일일 할당량 10개를 한 건도 쓰지 않았다** —
GSC 접속이 필요한 항목은 아래 다음 작업 1·2·3·5·6번으로 남는다.

1. **8-18 의 다음 작업 1번이 완료됐다.** §11.1 정정 34건을 커밋 `5cc2907`(06:42 KST)로 배포하고 live
   를 확인했다. `sitemap.xml` 이 저장소 파일과 동일(`2026-08-17` 0건, `2026-08-18` 22건), 매뉴얼 4개
   화면 표기가 `Updated 15 August 2026` / `2026년 8월 15일 갱신`, 70개 URL 재검증 70/70 정상.
2. **같은 날 배포가 하나 더 있었다 — 커밋 `a806fbd`(07:07 KST).** 홈 2개에 Simple Gas Mileage
   Calculator 개인정보 처리방침 블록을 추가했다. 새 URL 은 없고 sitemap `<loc>` 는 70 그대로다.
   범위와 검증은 §12 에 적었다.
3. **그 배포가 만든 `lastmod` 어긋남 2건을 같은 날 찾아 고쳤다.** `/`·`/ko/` 가 `2026-08-18` 로
   남아 있었다. §4.2 가 "배포마다 반복하는 점검" 으로 격상한 항목이 **8-17·8-18 에 이어 세 번째로
   적중**했다. 정정 후 분포는 `2026-08-14` 32 + `2026-08-15` 8 + `2026-08-16` 8 + `2026-08-18` 20 +
   `2026-08-19` 2 = **70** 이고 XML 은 well-formed 다.
4. **sitemap 미수집을 live 실측으로 재진단했다(§4.2).** 사이트 쪽 원인은 배제됐고, 8-13 실패를
   "개편 배포 전후의 혼란" 으로 설명하던 서술이 시점상 맞지 않아 정정했다. 남은 설명은 재시도
   백오프이며, **이 상태는 사이트를 고쳐서 풀리지 않는다** — Google 의 재시도나 재제출이 있어야 한다.

**다음 작업:**

1. **GSC sitemap 세부 화면을 열어 마지막으로 읽은 날짜를 기록한다.** 8-17 에는 목록 화면만 봤다.
   8-20 재제출 판정의 선결 확인이다 (§4.2). **여기서 처방이 갈린다** — ① 8-13 이후 재시도 자체가
   없었다면 재제출이 백오프를 끊는 정공법이고, ② 재시도했는데 또 실패했다면 재제출도 같은 결과일
   공산이 크므로 다른 원인을 봐야 한다 — 제출한 sitemap URL 의 오타, 그리고 **§4.1 에 적힌 속성
   유형(URL 접두어 `https://droidactor.github.io/`)과 제출 위치가 어긋나지 않는지**를 함께 대조한다.
2. **2026-08-20 — sitemap 재제출 판정.** 그날에도 `가져올 수 없음`이면 기존 행을 삭제하지 않은 채
   같은 `sitemap.xml`을 1회 제출한다 (§4.2). **단 선결 조건 "live sitemap = 저장소 파일" 이 아직
   확인되지 않았다** — 오늘의 `lastmod` 2건 정정을 push 하고 live 에서 `/`·`/ko/` 가 `2026-08-19`
   인지 확인한 뒤에야 재제출한다(§12 의 미완료 항목). **확인 전에 재제출하면 첫 성공 수집이
   `2026-08-18` 이 박힌 낡은 sitemap 으로 이뤄진다** — §10.1 이 8-17 에, §11.1 이 8-18 에 각각
   경계한 것과 같은 실패다.
3. **색인 생성 요청 10개 — `(ko/)tech-notes/bt-keyboard/` 허브 2개 먼저, 이어서 나머지 Tech Notes
   앱별 허브 8개**(`bt-ppt`, `bt-mouse`, `wifi-scout`, `ssh-scout` 의 한·영). `lgtv` 허브 2개와
   우선순위 2 의 10개는 그 다음 요청일로 넘긴다. 요청 전에 **8-17 에 요청한 10개를 URL 검사로 먼저
   확인한다**(URL 검사는 할당량을 소모하지 않는다) — 이미 크롤·색인됐으면 그 URL 은 다시 요청하지
   않고, 반대로 여전히 미색인이면서 크롤조차 없으면 그 사실을 기록한다.
   근거: 허브가 미색인이면 상세가 내부 링크로 발견될 사슬이 끊긴다는 것이 8-17 전수 스캔에서
   확인됐고(§4.3), 허브 1개가 상세 1~3개의 발견 경로를 대신하므로 할당량 효율이 높다.
4. **`bt-mouse` — 2026-08-20 까지 게시되지 않으면 배지·상태 문구를 게시 전 표기로 되돌린다** (§11.2).
   게시됐으면 스토어 링크 22곳이 `200` 인지 재확인한다. 404 링크를 품은 8개 페이지에 홈 2개가 들어
   있고, **그 홈 2개는 오늘 `lastmod` 가 `2026-08-19` 로 올라가 사이트에서 가장 신선한 신호를 달았다.**
5. **Page indexing 보고서는 최종 업데이트가 2026-08-14 이후로 넘어간 뒤에 다시 읽는다.** 그 전에
   읽은 수치로 개편의 성패를 판정하지 않는다.
6. **§5 링크 보고서를 8-20 에 다시 읽어 내부 링크가 여전히 0 인지 확인한다.** 색인 22 인데 링크
   그래프가 0 인 상태의 설명이 "보고서 지연" 뿐인지 그때 판정한다.
7. 옛 URL은 계속 요청하지 않고 Googlebot의 재크롤을 기다린다 (§4.4, §7).
8. **다음 배포 때도 §11.1 재현 절차를 그대로 돌린다.** `git log -1` 을 기계적으로 쓰지 않는다 —
   `5cc2907` 이 그 함정의 첫 사례이고, 오늘의 2건은 이 점검이 세 배포 연속으로 적중했음을 뜻한다.
9. **홈 2개의 처리방침 `Effective date` 를 어떻게 할지 정한다 (§12.1).** 새 앱의 처리방침 절이
   늘었는데 시행일은 `8 August 2026` 그대로다. 기계적으로 정할 수 없어 손대지 않았다.

### 7일 후

- [ ] sitemap의 마지막 읽은 날짜가 이동 이후로 갱신됐는지 확인한다.
- [ ] 발견된 페이지 수가 70으로 바뀌었는지 확인한다.
- [ ] Page indexing 보고서를 해당 sitemap으로 필터링해 색인됨·비색인 수와 제외 사유를 기록한다.
- [ ] 우선순위 1·2 URL의 발견 여부·색인 상태·마지막 crawl 날짜를 확인하고 요청 대상을 선별한다.
- [ ] Page indexing에서 redirect 오류·soft 404·canonical 불일치가 늘지 않았는지 확인한다.

### 14일 후

- [ ] 새 제품 URL 14개 중 Google이 발견한 수를 기록한다.
- [ ] 새 매뉴얼 URL 12개와 허브 4개 중 Google이 발견한 수를 기록한다.
- [ ] 새 Tech Notes URL 20개(§2.3 14 + §9 2 + §10 4) 중 Google이 발견한 수를 기록한다.
- [ ] 비색인 URL은 `발견됨 - 현재 색인이 생성되지 않음`, duplicate, soft 404 등 정확한 제외 사유를 기록한다.
- [ ] 새 URL의 Google-selected canonical이 self canonical인지 표본 검사한다.
- [ ] 옛 제품 URL 검색 결과가 새 `/apps/` URL로 교체되기 시작했는지 확인한다.

### 30일 후

- [ ] Performance 보고서에서 `페이지` 기준으로 옛 제품 URL과 새 제품 URL의 노출을 비교한다.
- [ ] 옛 URL 노출은 감소하고 새 URL 노출은 증가하는지 확인한다.
- [ ] 새 URL이 발견되지 않았다면 해당 URL의 referring sitemap·referring page·last crawl을 점검한다.
- [ ] sitemap이 계속 실패할 때만 live fetch·XML parsing·robots 접근을 다시 진단한다.

완료 조건은 sitemap 수집과 실제 색인을 구분한다.

Sitemap 수집 완료:

- [ ] sitemap 상태가 성공이고 발견된 페이지가 70이다.
- [ ] 이 70은 sitemap에서 파싱한 고유 URL 수이며, crawl 또는 index 완료 수가 아님을 확인했다.

색인 전환 완료:

- [ ] Page indexing 보고서를 sitemap으로 필터링한 색인됨·비색인 수와 각 제외 사유를 기록했다.
- [ ] 허브 4개, 출시 앱 제품 6개, 출시 앱 대표 매뉴얼 6개를 URL 검사해 `URL이 Google에 등록되어 있음`과
      Google-selected canonical을 확인했다.
- [ ] Tech Notes 허브 2개를 URL 검사하고, 상세 문서 12개의 발견·색인 상태 또는 비색인 사유를 기록했다.
- [ ] 제품 결과가 새 `/apps/<app>/`, `/ko/apps/<app>/` URL로 전환된다.
- [ ] 나머지 제품·매뉴얼 URL은 색인 상태가 확인되거나, 비색인 사유와 후속 조치가 기록된다.
- [ ] 표본 검사한 새 URL의 canonical이 Google-selected canonical과 일치한다.
- [ ] 옛 URL에서 잘못된 대상·redirect chain·soft 404가 발생하지 않는다.

Google은 소규모 사이트도 URL 이동 처리가 수 주 걸릴 수 있으며, 색인 요청은 색인을 보장하지 않는다고
안내한다. 요청 직후 수치가 바뀌지 않아도 반복 제출하거나 redirect를 제거하지 않는다.

## 7. 하지 말아야 할 것

- 옛 제품 URL을 `404`로 바꾸지 않는다.
- 옛 제품 URL을 모두 홈이나 앱 허브 하나로 몰아 보내지 않는다.
- redirect를 여러 단계로 연결하지 않는다.
- 옛 제품 URL을 sitemap에 다시 넣지 않는다.
- Search Console sitemap 행을 삭제했다가 다시 만들지 않는다.
- 주소 변경 도구를 사용하지 않는다.
- 삭제 도구로 옛 URL을 숨기지 않는다.
- 새 URL 색인 요청을 같은 날 반복하지 않는다.
- 소유권 확인 파일 **3개를 모두** 삭제하지 않는다 — `googlec8773d84a9d25688.html`,
  `google6e10b6b19ade6d42.html`(Google), `naver291cd179e909bd205a8a0bf7179d3588.html`(네이버).
  이 목록은 2026-08-19 저장소 스윕으로 확정했다(§12.2). 그전에는 첫 번째 것만 적혀 있었다.

## 8. 공식 참고 자료

- [Site Moves and Migrations](https://developers.google.com/search/docs/crawling-indexing/site-move-with-url-changes)
- [Redirects and Google Search](https://developers.google.com/search/docs/crawling-indexing/301-redirects)
- [Change of Address tool](https://support.google.com/webmasters/answer/9370220)
- [URL Inspection tool](https://support.google.com/webmasters/answer/9012289)
- [Build and submit a sitemap](https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap)
- [Sitemaps report](https://support.google.com/webmasters/answer/7451001)
- [Canonicalization](https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls)
- [Removals tool](https://support.google.com/webmasters/answer/9689846)

## 9. Google TV Bluetooth HID 조사 글 추가 URL

2026-08-14에 bt-mouse의 Bluetooth HID가 Google TV 페어링 목록에서 보이지 않는 원인을 분석한 한·영 글을
추가했다. 기존 64 URL에 더해 sitemap의 예상 URL 수는 66개다. 배포 뒤 live 응답·self canonical·상호
`hreflang`을 확인하고, 먼저 sitemap에 맡긴다. 7~14일 뒤에도 미발견 또는 비색인이면 필요한 URL만 검사한다.

- [x] `https://droidactor.github.io/tech-notes/bt-keyboard/why-google-tv-does-not-detect-bluetooth-hid.html`
- [x] `https://droidactor.github.io/ko/tech-notes/bt-keyboard/why-google-tv-does-not-detect-bluetooth-hid.html`

**2026-08-15 live 실측 — 2개 모두 배포·확인 완료다.**

- 둘 다 `200`.
- self canonical 정확(각자 자기 URL).
- `hreflang` 3개(`en`, `ko`, `x-default`)가 서로를 정확히 가리키며 `x-default` 는 영문판이다.
- `noindex` 없음.
- sitemap 의 `<loc>` 수가 **66개**로 예상과 일치하고, 이 2개가 실제로 포함돼 있다.

색인 요청은 하지 않았다. 계획대로 sitemap·내부 링크에 맡기고, 7~14일 뒤 미발견이면 그때 선별한다.

**2026-08-17 URL 검사 — 2개 모두 여전히 미색인이다**(`참조 페이지: 감지된 페이지 없음`,
`최근 크롤링: 해당사항 없음`). 부모 허브 `(ko/)tech-notes/bt-keyboard/` 도 함께 미색인이라
"허브를 통한 발견" 경로가 성립하지 않는다. 상세는 §4.3 의 8-17 전수 스캔 표를 본다.

## 10. bt-keyboard 상세 기술 노트 추가 URL — 4개

2026-08-16 에 bt-keyboard 기술 노트 2건을 한·영으로 추가했다. 커밋은 `842eb3d`(한/영 각인이 어긋나는
이유)와 `ec0f0cf`(HID 세션 공유) 두 개이며, 둘 다 같은 날 배포됐다. 이 4개로 sitemap `<loc>` 수는
66 → **70** 이 됐다.

- [x] `https://droidactor.github.io/tech-notes/bt-keyboard/why-korean-english-key-labels-drift.html`
- [x] `https://droidactor.github.io/ko/tech-notes/bt-keyboard/why-korean-english-key-labels-drift.html`
- [x] `https://droidactor.github.io/tech-notes/bt-keyboard/sharing-one-bluetooth-hid-session.html`
- [x] `https://droidactor.github.io/ko/tech-notes/bt-keyboard/sharing-one-bluetooth-hid-session.html`

**2026-08-17 live 실측 — 4개 모두 배포·확인 완료다.**

- 4개 전부 `200`.
- self canonical 정확(각자 자기 URL).
- `hreflang` 3개(`en`, `ko`, `x-default`)가 서로를 정확히 가리키며 `x-default` 는 영문판이다.
- `noindex` 없음(`<meta name="robots">` 자체가 없다).
- live sitemap 의 `<loc>` 수가 **70개**이고 이 4개가 실제로 포함돼 있다.
- **URL 검사(2026-08-17): 4개 전부 미색인.** `참조 페이지: 감지된 페이지 없음`,
  `최근 크롤링: 해당사항 없음`. 색인 생성 요청은 하지 않았다 — 부모 허브가 먼저다(§4.3).

### 10.1 sitemap `lastmod` 정정 — 26개 (2026-08-18 `9a397f5` 로 배포 완료)

§4.2 의 "`lastmod` 가 실제 최종 변경일인지" 점검에서 어긋난 값을 찾아 2026-08-17 에 고쳤다.
**작성 시점에는 미배포였고, 2026-08-18 커밋 `9a397f5` 가 이 변경을 함께 담아 배포했다** — live
`sitemap.xml` 이 저장소 파일과 동일함을 그날 확인했다(§11). 8-20 재제출의 선결 조건이던 항목이므로
그 제약은 해소됐다.

정정은 두 묶음이다. **처음에는 아래 A 6개만 고쳤는데, 그 결과 sitemap 에서 `2026-08-15` 가 완전히
사라져 "8-15 에는 아무것도 바뀌지 않았다" 는 잘못된 상태가 됐다.** 검토에서 이 범위 누락을 잡아
B 20개를 함께 고쳤다.

#### A. `2026-08-15` → `2026-08-16` — 6개

| URL | 고치기 전 | 고친 뒤 | 사유 |
|---|---|---|---|
| `/tech-notes/bt-keyboard/` | 2026-08-15 | 2026-08-16 | `ec0f0cf` 로 sharing 노트 링크가 실제로 추가됐는데 `lastmod` 가 그대로였다 |
| `/ko/tech-notes/bt-keyboard/` | 2026-08-15 | 2026-08-16 | 위와 같다 |
| `/tech-notes/bt-keyboard/why-google-tv-does-not-detect-bluetooth-hid.html` | 2026-08-15 | 2026-08-16 | `842eb3d` 에서 수정됐고 그 커밋·배포일이 8-16 이다 |
| `/ko/tech-notes/bt-keyboard/why-google-tv-does-not-detect-bluetooth-hid.html` | 2026-08-15 | 2026-08-16 | 위와 같다 |
| `/tech-notes/bt-keyboard/why-korean-english-key-labels-drift.html` | 2026-08-15 | 2026-08-16 | 신규 추가 커밋 `842eb3d` 의 날짜가 8-16 이다 |
| `/ko/tech-notes/bt-keyboard/why-korean-english-key-labels-drift.html` | 2026-08-15 | 2026-08-16 | 위와 같다 |

판단 근거는 **`lastmod` 의 기준이 로컬 작성일이 아니라 콘텐츠가 공개적으로 바뀐 배포일**이라는 점이다.
두 커밋 모두 `2026-08-16`(`842eb3d` 08:42 KST, `ec0f0cf` 19:59 KST)이므로 8-15 는 어느 파일에도 맞지
않는다. 특히 허브 2개는 `ec0f0cf` 에서 본문이 바뀌었는데 sitemap 은 새 URL 2개만 넣고 허브의 `lastmod`
갱신을 빠뜨렸다 — sitemap 자신의 머리주석이 "When a page is added or its content changes, update
`<lastmod>` for that pair." 라고 적어 둔 규약을 어긴 상태였다.

#### B. `2026-08-14` → `2026-08-15` — 20개

커밋 `a795df6`(2026-08-15 07:27 KST)이 실제로 본문을 바꾼 URL 인데 `lastmod` 가 `2026-08-14` 로
남아 있던 것들이다. 변경 내용은 사소하지 않다 — `<span class="badge soon">Coming soon</span>` 이
Google Play 배지 링크로 바뀌었고, 사양표 `Status` 행이 `Not yet published on Google Play` 에서
`Published on Google Play — store listing` 으로, 푸터에 상표 고지 `<p class="tm">` 가 추가됐다.
**A 의 "허브에 링크 한 줄 추가" 보다 훨씬 큰 변경이고, 상업적으로도 가장 중요한 변경(스토어 링크)이다.**

| 묶음 | URL |
|---|---|
| 홈 2개 | `/`, `/ko/` |
| 제품 6개 | `(ko/)apps/{bt-ppt, bt-mouse, ssh-scout}/` |
| 매뉴얼 6개 | `(ko/)manual/{bt-ppt, bt-mouse, ssh-scout}/` |
| 블로그 6개 | `(ko/)blog/{use-android-phone-as-powerpoint-remote, use-android-phone-as-bluetooth-mouse, find-and-connect-to-ssh-hosts-from-android}/` |

`README.md` 도 같은 커밋에서 바뀌었지만 sitemap 대상이 아니므로 제외했다.

#### 정정 결과

`lastmod` 분포는 `2026-08-14` 42개 + `2026-08-15` 20개 + `2026-08-16` 8개 = **70개**이고 XML 은
well-formed 다. **이 수치는 A·B 두 묶음까지만 검증한 값이며 "sitemap 의 모든 `lastmod` 가 옳다" 는
뜻이 아니다** — 앞으로 부분 배포를 할 때마다 같은 대조(`git log -1 --date=iso-local -- <path>` ↔
sitemap `lastmod`)를 반복한다.

**아직 Google 이 이 sitemap 을 한 번도 성공적으로 읽지 못했으므로(§4.2) 이 정정에는 부작용이 없다** —
이미 수집된 값을 되돌리는 것이 아니라 첫 수집 전에 맞추는 일이다. **단 그 무해함은 배포를 마쳤을 때만
성립한다.** 미배포 상태로 8-20 재제출을 하면 첫 성공 수집이 틀린 `lastmod` 로 이뤄진다.

**2026-08-18 후속.** 배포는 끝났고(`9a397f5`), 위 "앞으로 부분 배포를 할 때마다 반복한다" 는 약속을
그 배포에 적용한 결과가 §11.1 이다. 같은 커밋이 `lastmod` 10건과 `dateModified` 20건을 새로 어긋나게
만들었고 그 자리에서 고쳤다. 위 분포 수치(42+20+8)는 8-17 시점 기록이므로 그대로 두고, 현재 분포는
§11.1 에서 본다.

## 11. 2026-08-18 배포 — 블로그 앱 카드·스크린샷의 Google Play 링크 전환

커밋 `9a397f5`(2026-08-18 18:05 KST). **새 URL 은 없고 기존 22개 URL 의 본문이 바뀐 배포다.** sitemap
`<loc>` 수는 70 그대로이므로 이동 처리나 신규 URL 발견 절차는 대상이 아니고, `lastmod`·`dateModified`
갱신과 live 검증만 대상이다. 커밋이 손댄 배포 파일은 24개(22개 페이지 + `sitemap.xml` + `assets/site.css`)다.

본문이 바뀐 22개 URL:

| 묶음 | 개수 | URL |
|---|---|---|
| 홈 | 2 | `/`, `/ko/` |
| 앱 허브 | 2 | `/apps/`, `/ko/apps/` |
| 매뉴얼 허브 | 2 | `/manual/`, `/ko/manual/` |
| bt-mouse 제품 | 2 | `(ko/)apps/bt-mouse/` |
| bt-mouse 매뉴얼 | 2 | `(ko/)manual/bt-mouse/` |
| 블로그 앱 소개 글 | 12 | `(ko/)blog/{use-android-phone-as-bluetooth-mouse, use-android-phone-as-powerpoint-remote, find-and-connect-to-ssh-hosts-from-android, find-devices-on-wifi-from-android, control-lg-webos-tv-over-wifi, type-korean-over-bluetooth-hid}/` |

검증 결과:

- [x] **live 전수 `200`** — sitemap 의 70개 URL 전부 `200` + self canonical 일치 + `noindex` 없음 +
      `hreflang` 2개 이상. 70/70.
- [x] **옛 제품 URL 14개** — 14/14 가 `200` + `meta refresh 0; url=<대응 새 URL>` 1:1 + 대응 새 URL
      canonical + `noindex` 없음. §3·§4.4 의 점검을 배포 단위로 반복한 것이다.
- [x] **live `sitemap.xml` = 저장소 파일** — `<loc>` 70개, XML well-formed, `application/xml`.
      즉 §10.1 의 26건 정정이 live 에 반영됐다.
- [x] **`lastmod`·`dateModified`·화면 표기 대조** — 어긋남 34건을 찾아 고쳤다(§11.1, 8-19 배포).
      `lastmod` 10 + `dateModified` 20 + 매뉴얼 화면 표기 4 다.
- [ ] **`bt-mouse` 스토어 링크** — 22곳이 현재 `404` 다(§11.2). 게시 후 재확인이 남았다.

### 11.1 날짜 신호 정정 34건 — `lastmod` 10 + `dateModified` 20 + 화면 표기 4

**정정은 2026-08-18 에 하고 배포는 2026-08-19 에 했다** — 커밋 `5cc2907`
("날짜 신호 34건 정정 — lastmod 10, dateModified 20, 화면 표기 4").
**이 커밋의 날짜(8-19)는 어떤 `lastmod` 의 기준일도 아니다** — 날짜 필드와 화면 표기만 고쳤고 독자가
읽는 내용은 한 글자도 바뀌지 않았으므로, 아래 재현 절차에서 건너뛸 대상이다. 이 구분이 없으면 정정할
때마다 날짜가 하루씩 밀린다.

대조 방법은 두 축이다.

1. sitemap 의 `<lastmod>` ↔ 그 URL 파일의 마지막 **본문 변경** 배포일
2. 페이지 JSON-LD 의 `dateModified` ↔ 같은 기준일

**"본문 변경" 이 기준이라는 점이 중요하다.** 날짜 필드만 고치는 이번 정정 커밋은 콘텐츠 변경이
아니므로 그 커밋 날짜로 `lastmod` 를 다시 당기지 않는다. 이 구분이 없으면 정정할 때마다 날짜가 하루씩
밀려 영구히 수렴하지 않는다. 반대로 `git log -1` 만 기계적으로 믿어도 같은 함정에 빠진다.

#### A. `lastmod` `2026-08-17` → `2026-08-18` — 10개

| 묶음 | URL |
|---|---|
| 블로그 5쌍 | `(ko/)blog/{type-korean-over-bluetooth-hid, use-android-phone-as-powerpoint-remote, find-devices-on-wifi-from-android, find-and-connect-to-ssh-hosts-from-android, control-lg-webos-tv-over-wifi}/` |

**2026-08-17 에는 배포가 없었다.** 그날 자 커밋이 아예 없고(`ec0f0cf` 8-16 → `9a397f5` 8-18), 이 10개
페이지가 마지막으로 바뀐 커밋은 `9a397f5` 하나다. 즉 이 콘텐츠가 공개적으로 바뀐 날은 8-18 이다.
같은 커밋이 손댄 블로그 12개 중 `use-android-phone-as-bluetooth-mouse` 쌍만 8-18 로 적혀 있었으므로,
한 커밋의 `lastmod` 가 두 날짜로 갈려 있던 상태였다. (그 커밋 시점의 8-18 은 12개였고 — 홈 2, 허브 4,
bt-mouse 제품·매뉴얼 4, mouse 블로그 2 — 나머지 블로그 10개만 8-17 이었다.)

정정 후 분포: `2026-08-14` 32 + `2026-08-15` 8 + `2026-08-16` 8 + `2026-08-18` 22 = **70**, XML
well-formed. `2026-08-17` 은 사라진다 — 그날 공개된 변경이 없으므로 맞다.

#### B. `dateModified` 20개

| 대상 | 개수 | 고치기 전 | 고친 뒤 | 근거 커밋(배포일) |
|---|---|---|---|---|
| 블로그 5쌍 | 10 | 2026-08-17 | 2026-08-18 | `9a397f5` (8-18) — 도입부 앱 카드·스크린샷 링크 전환 |
| `(ko/)manual/{bt-ppt, ssh-scout}/` | 4 | 2026-08-14 | 2026-08-15 | `a795df6` (8-15) — Play 배지와 상표 고지 추가 |
| `(ko/)tech-notes/bt-keyboard/` | 2 | 2026-08-15 | 2026-08-16 | `ec0f0cf` (8-16) — 허브 목록에 sharing 노트 링크 추가 |
| `(ko/)…/why-google-tv-does-not-detect-bluetooth-hid.html` | 2 | 2026-08-15 | 2026-08-16 | `842eb3d` (8-16) — article 내 관련 노트 링크 1개 추가 |
| `(ko/)…/why-korean-english-key-labels-drift.html` | 2 | 2026-08-15 | 2026-08-16 | `842eb3d` (8-16) — 신규 추가 |

**갱신/유지를 가르는 규칙은 이렇게 읽는다** — `dateModified` 는 **article 안에서 독자가 보는 것이
늘거나 바뀌었을 때** 갱신하고, **전역 푸터·탐색 링크와 `href` 대상 교체만**이면 유지한다. 위 5줄과
아래 C 4개가 이 규칙으로 전부 설명된다. 애매한 사례가 실제로 있었다 —
`why-google-tv-does-not-detect-bluetooth-hid.html` 은 산문이 한 글자도 안 바뀌고 article 안
`manual-actions` 에 관련 노트 링크 하나가 늘었다. **독자에게 보이는 것이 늘었으므로 갱신 쪽이다.**
반대로 C 의 4개는 같은 앵커 텍스트의 `href` 대상만 바뀌었다.

`why-korean-english-key-labels-drift.html` 2개는 `datePublished` 도 `2026-08-15` → `2026-08-16` 으로
같이 고쳤다. 로컬 작성일이 8-15 였을 뿐 공개된 날은 8-16 이다. §10.1 A 가 같은 파일의 sitemap
`lastmod` 에 이미 적용한 판단을 페이지 안 구조화 데이터에도 맞춘 것이다.

#### B-2. 화면에 보이는 갱신 날짜 4개 — `2026-08-14` → `2026-08-15`

`(ko/)manual/{bt-ppt, ssh-scout}/` 의 `<p class="manual-meta">` 표기를 `Updated 14 August 2026` /
`2026년 8월 14일 갱신` → `15 August 2026` / `8월 15일 갱신` 으로 함께 고쳤다. **구조화 데이터만 올리고
화면 표기를 두면 둘이 어긋난다** — Google 은 Article 계열에서 보이는 날짜를 채택하거나 구조화 날짜를
무시하므로, 그대로 두면 방금 고친 8-15 신호가 버려진다. `9a397f5` 가 `manual/bt-mouse` 에서
`dateModified` 와 `Updated … 2026` 을 함께 고친 선례가 이 저장소의 관례다.

같은 점검에서 **`why-korean-english-key-labels-drift.html` 의 화면 표기는 일부러 두었다.** 그 줄은
`Source baseline: app 1.0.0 (2) · 15 August 2026` / `소스 기준: 앱 1.0.0 (2) · 2026년 8월 15일` 로
**분석에 사용한 소스 스냅샷 날짜**이지 발행일 표기가 아니다. `datePublished` 8-16(공개된 날)과 다른
사실을 말하므로 어긋남이 아니다 — 다음 세션이 "동기화" 하지 않도록 여기 적어 둔다.

#### C. 일부러 고치지 않은 것 — `dateModified` `2026-08-03` 4개

`(ko/)blog/{find-ls-plc-ip-address, identify-industrial-devices-by-port}/` 는 `dateModified` 가
`2026-08-03` 인데 sitemap `lastmod` 는 `2026-08-14` 다. **이 불일치는 정상이다.**

- `lastmod` 는 **페이지**가 바뀐 날이다. 8-14 개편이 이 페이지들의 링크 대상(`/wifi-scout/` →
  `/apps/wifi-scout/`)과 푸터 탐색을 바꿨으므로 8-14 가 맞다.
- `dateModified` 는 **글**이 바뀐 날이다. 8-14 diff 를 확인한 결과 본문 문장은 그대로이고 링크
  대상과 푸터만 바뀌었으므로 8-03 을 유지한다.

이 구분을 잃으면 링크 정리 배포마다 모든 글의 `dateModified` 가 갱신되어 "글이 개정됐다" 는 잘못된
신호를 보낸다.

#### 재현 절차

배포마다 아래 대조를 반복한다. 결과가 0건이어야 정상이며, 어긋남이 나오면 그 배포가 실제로 무엇을
바꿨는지 diff 로 확인한 뒤 위 규칙으로 방향을 정한다.

```bash
# 이 파일을 바꾼 커밋 목록 — 맨 위가 최신
git log --format='%h %ad %s' --date=short -- <path>
# 그중 "날짜 필드만 고친 정정 커밋" 은 건너뛰고, 그 아래 첫 실질 변경 커밋의 날짜를 기준으로 쓴다
git show <hash> -- <path>          # article 내 변경인지 푸터·href 뿐인지 확인
grep -o '"dateModified"[^,]*' <path>                # ↔ sitemap <lastmod>
grep -o '<p class="manual-meta">[^<]*' <path>       # ↔ 화면에 보이는 날짜(매뉴얼)
```

**`git log -1` 을 그대로 쓰면 안 된다.** 이 정정 자체가 커밋되는 순간 매뉴얼 4개와 Tech Notes 6개의
`git log -1` 은 8-18 을 돌려주는데 `lastmod` 는 8-15·8-16 이므로, 어긋남 10건이 거짓으로 뜬다. 그대로
믿고 날짜를 당기면 정정할 때마다 하루씩 밀리는 드리프트가 실제로 생긴다. **날짜 필드·화면 표기만 고친
커밋은 기준일이 아니다.**

#### 남겨 둔 오기 — `assets/site.css?v=20260817-blog-play-link`

`9a397f5` 가 12개 페이지에 붙인 CSS 캐시 토큰의 날짜가 `20260817` 인데 실제 배포일은 8-18 이다.
**고치지 않았다** — 토큰을 바꾸면 그 12개 페이지 본문이 또 바뀌어 `lastmod` 를 다시 갱신해야 하고,
`Cache-Control: max-age=600` 이라 캐시 문제도 없다. 하이픈 없는 표기라 `2026-08-17` grep 에도 걸리지
않으므로, **이 토큰을 "8-17 에 배포가 있었다" 는 증거로 읽지 말 것.** 8-17 자 커밋은 없다.

### 11.2 `bt-mouse` 스토어 링크 22곳이 현재 `404` — 게시 후 재확인 필요

`9a397f5` 는 재등록 예정 패키지명 `com.droidactor.bt_mouse2` 를 **게시 전에** 사이트 전역으로
선반영했다(커밋 메시지가 그렇게 밝히고 있다). 2026-08-18 실측 결과는 다음과 같다.

| 패키지 | 링크 수 | Google Play 응답 |
|---|---|---|
| `com.droidactor.wifi_scout` | 32 | `200` |
| `com.droidactor.ssh_scout` | 24 | `200` |
| `com.droidactor.lgtv` | 24 | `200` |
| `com.droidactor.bt_ppt` | 22 | `200` |
| `com.droidactor.bt_keyboard` | 20 | `200` |
| **`com.droidactor.bt_mouse2`** | **22** | **`404`** |
| `com.droidactor.bt_mouse` (옛 이름) | 0 | `404` |

`/apps/bt-mouse/` 사양표는 `Published on Google Play —` 로 적혀 있어, 현재는 페이지의 주장과 스토어
실제 상태가 어긋난다. **의도된 선반영이므로 사이트를 되돌리지 않았다.** 다만 게시가 늦어지는 동안
① 방문자가 `404` 에 도달하고 ② 색인된 페이지가 사실과 다른 공개 상태를 주장한다.

**타이밍이 나쁘게 겹친다.** 404 링크를 품은 페이지는 8개이고 그중 **홈 2개**가 들어 있다
(`/`, `/ko/`, `(ko/)apps/bt-mouse/`, `(ko/)manual/bt-mouse/`, `(ko/)blog/use-android-phone-as-bluetooth-mouse/`).
이 8개가 8-18 배포로 가장 신선한 `lastmod` 코호트에 들어갔고(**그중 홈 2개는 8-19 배포로
`2026-08-19` 로 다시 올라갔다 — §12.** 나머지 6개는 `2026-08-18` 그대로다), 다음 작업은 색인 요청
10건으로 크롤을 더 부른다. 즉 **크롤을 적극적으로 부르는 기간과 CTA 가 죽은 기간이 겹친다.**

**되돌림 기준일 = 2026-08-20**(sitemap 재제출 판정일과 같은 날). 그날까지 게시가 안 되면 배지·상태
문구를 게시 전 표기로 되돌린다. 게시되면 위 표를 재확인해 22곳이 `200` 인지 본다.

## 12. 2026-08-19 배포 — Simple Gas Mileage Calculator 개인정보 처리방침 앵커 추가

커밋 `a806fbd`(2026-08-19 07:07 KST). **새 URL 은 없고 홈 2개의 본문이 바뀐 배포다.** sitemap `<loc>`
수는 70 그대로이므로 이동 처리나 신규 URL 발견 절차는 대상이 아니고, `lastmod` 갱신과 live 검증만
대상이다. 커밋이 손댄 배포 파일은 `index.html`·`ko/index.html` 2개다.

**같은 날 커밋 `5cc2907`(06:42 KST)도 배포됐지만 그것은 §11.1 의 날짜 신호 정정이고 콘텐츠 변경이
아니므로 어떤 `lastmod` 의 기준일도 아니다**(§11.1 머리말). 하루에 두 커밋이 배포된 날이므로 이
구분을 특히 놓치기 쉽다 — 기준일을 주는 것은 `a806fbd` 하나뿐이다.

변경 내용은 개인정보 처리방침 7장 뒤에 `<div class="policy" id="privacy-gas">` 블록을 넣은 것이다 —
`<h3>` 제목 + `<span class="pkg-inline">com.droidactor.SimpleGasMileage</span>` + 본문 두 단락(입력한
숫자로 계산만 하고 기기에 머문다 / 배너 광고 1개). **독자가 보는 것이 늘어난 본문 변경**이므로
§11.1 B 가 세운 **판정 기준**("독자가 보는 것이 늘거나 바뀌었는가")으로 갱신 쪽이다 — 다만 여기서
갱신하는 대상은 `dateModified` 가 아니라 §11.1 의 대조축 1 인 sitemap `lastmod` 다. 파일 상단 주석의
앵커 목록도 갱신하며 누락돼 있던 `#privacy-lgtv` 를 함께 반영했다(주석이므로 그 자체는 화면 변화가
아니다).

**제품 페이지를 만들지 않은 것은 의도다** — 커밋 메시지가 "Dotori 브랜드 앱이 아니므로 dotori span 과
제품 페이지 링크는 두지 않았다" 고 밝히고 있다. 그래서 이 배포에는 `/apps/…` 계열 신규 URL 이 없고
sitemap 도 늘지 않는다. 다음 세션이 "앱이 늘었는데 제품 페이지가 없다" 를 누락으로 오판하지 않도록
적어 둔다.

검증 결과 (2026-08-19 07:55 KST live 실측):

- [x] **홈 2개 live 반영** — `/`·`/ko/` 둘 다 `200` + `id="privacy-gas"` 1개 + `#privacy-lgtv` 1개 +
      `com.droidactor.SimpleGasMileage` 존재 + self canonical 일치 + `noindex` 없음 + `hreflang` 7개.
- [x] **`lastmod` 대조 — 어긋남 2건을 찾아 고쳤다.** `/`·`/ko/` 가 `2026-08-18` 로 남아 있어
      `2026-08-19` 로 정정했다(`sitemap.xml` 의 `<loc>` 첫 두 블록). 정정 후 `<loc>` 70개,
      XML well-formed, 분포 `2026-08-14` 32 + `2026-08-15` 8 + `2026-08-16` 8 + `2026-08-18` 20 +
      `2026-08-19` 2 = 70.
- [x] **`dateModified`·화면 표기는 이 배포의 대조 대상이 아니다.** 홈 2개에는 JSON-LD 날짜 필드가
      없고(`"date…"` grep 0건), 매뉴얼의 `<p class="manual-meta">` 같은 갱신일 표기도 없다. 따라서
      §11.1 B·B-2 의 **대상 필드가 이 배포에 존재하지 않는다**(위 판정 기준과 혼동하지 않는다).
      대조축은 sitemap `lastmod` 하나뿐이다. **홈에만 있는 날짜인 `Effective date` 는 성격이 달라
      아래 §12.1 로 분리한다.**
- [x] **저장소 전수 스윕 — sitemap 누락 URL 0건.** HTML 89개를 훑어 sitemap `<loc>` 70개와 대조했다.
      sitemap 밖 19개는 전부 의도된 제외다 — 옛 제품 URL 호환 페이지 14개(§2.1·§7 이 sitemap 재등록을
      금지), `404.html`·`blog/_post-template.html`(둘 다 `noindex`), 소유권 확인 파일 3개
      (`googlec8773d84a9d25688.html`, `google6e10b6b19ade6d42.html`, `naver291cd179…html`).
      **역방향도 0건** — sitemap 에만 있고 대응 파일이 없는 URL 은 없다.
      (`google6e10b6b19ade6d42.html` 은 `113d6ea`(8-07)로 추가된 **두 번째** Google 확인 파일인데
      §3·§7 은 `googlec8773d84a9d25688.html` 하나만 적고 있다 — 아래 §12.2.)
- [ ] **push 후 live 재확인** — live `sitemap.xml` 이 저장소 파일과 같아지고 `/`·`/ko/` 가
      `2026-08-19` 인지 본다. **8-20 재제출의 선결 조건이다.**
- [ ] **Play Console 처리방침 URL 등록 확인** — Simple Gas Mileage Calculator 의 처리방침 URL 이
      `https://droidactor.github.io/#privacy-gas`(ko 는 `/ko/#privacy-gas`)로 등록됐는지.
      `index.html` 상단 주석이 `Do not rename the #privacy-* anchors — they are registered on the
      store listings` 라고 못박은 대로, 앵커를 만든 것과 스토어에 등록하는 것은 별개 작업이다.
      같은 커밋이 발견한 누락 앵커 `#privacy-lgtv` 도 함께 본다.
- [ ] **개인정보 처리방침 `Effective date` 판단** — §12.1.

### 12.1 홈 2개의 `Effective date` — 판단이 필요해 일부러 두었다

`index.html:250`·`ko/index.html:222` 의 `Effective date: 8 August 2026` / `시행일: 2026년 8월 8일` 은
그대로다. 그런데 같은 문서가 바로 아래 8장에서 **"If this policy changes, the updated version is posted
on this page with a new date"** 라고 약속하고 있고, 이번에 앱 하나의 처리방침 절이 새로 늘었다.

- 기존 조항의 **내용은 하나도 바뀌지 않았고 새 앱에 대한 공개 범위만 늘었다.** 이것을 "정책 변경"
  으로 볼지가 갈림길이다.
- 이것은 검색 신호 문제가 아니라 **문서의 자기 약속과 스토어 심사** 쪽 문제다. `lastmod` 처럼
  기계적으로 정할 수 없다.
- 그래서 **의도적으로 두었다.** 다음 세션이 "날짜 동기화" 로 판단해 자동으로 바꾸지 않도록 여기
  적어 둔다 — §11.1 B-2 가 `why-korean-english-key-labels-drift.html` 의 `Source baseline` 표기를
  남겨 둔 것과 같은 취지다.

### 12.2 소유권 확인 파일이 3개였다 — 문서는 하나만 보호하고 있었다

이 배포와 직접 관계는 없고, 위 전수 스윕에서 드러난 것이다. 루트에 site verification 파일이 셋 있다.

| 파일 | 추가 커밋 | 용도 |
|---|---|---|
| `googlec8773d84a9d25688.html` | `5206b25` (2026-08-02, "Search Console 소유권 확인 파일 추가") | Google |
| `google6e10b6b19ade6d42.html` | `113d6ea` (2026-08-07, "권한 확인 파일: 필수. 삭제하지 말것.") | Google — 별개 토큰 |
| `naver291cd179e909bd205a8a0bf7179d3588.html` | `687f2cd` (2026-08-10) | 네이버 서치어드바이저 |

그런데 §3 의 확인 항목과 §7 의 금지 목록은 **첫 번째 것만** 적고 있었다. 나머지 둘은 문서상 보호되지
않아 정리 작업에서 지워질 수 있었고, 그러면 소유권 확인이 풀린다. §7 에 셋을 모두 적었다.

**두 번째 Google 토큰의 정체는 미확인이다.** 같은 속성에 추가한 확인 방법일 수도, 다른 계정·다른
Google 제품의 확인일 수도 있다. 커밋 제목이 "필수. 삭제하지 말것." 뿐이라 저장소만으로는 갈리지 않는다.
**8-20 에 GSC 를 열 때 함께 확인한다** — 재제출 판정에서 ②번 갈래(재시도했는데 또 실패)로 갔을 때의
후보 원인이 "제출 위치와 보고 있는 속성이 어긋남" 이므로(§6 8-19 다음 작업 1번), 이 속성에 확인 주체가
몇이고 소유자가 누구인지는 그 진단과 맞물린다.

- [ ] GSC `설정 > 소유권 확인` 에서 확인 방법 목록과 소유자를 보고 두 번째 Google 토큰의 정체를 기록한다.
