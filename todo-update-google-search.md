# Google Search URL 변경 후속 작업

작성일: 2026-08-14

기준 변경: `f300f26` — 앱·매뉴얼 URL 구조 개편

후속 변경: 6개 앱의 한·영 Tech Notes 14개 추가

## 1. 결론

이번 변경은 도메인이나 protocol 변경이 아니라 **같은 Search Console 속성 안에서 URL path만 바꾼 것**이다.

- 기존 Search Console 속성 `https://droidactor.github.io/`를 그대로 사용한다.
- 새 속성을 추가하지 않는다.
- **주소 변경(Change of Address) 도구는 사용하지 않는다.** Google은 같은 사이트 안의 path 이동에는
  redirect와 sitemap 갱신을 사용하라고 명시한다.
- Search Console의 **삭제(Removals) 도구로 옛 URL을 지우지 않는다.** 이 도구는 content 이동용이 아니며,
  redirect·canonical 신호의 정상 처리를 방해할 수 있다.
- sitemap 제출 주소는 계속 `https://droidactor.github.io/sitemap.xml`이다.
- 경로 개편으로 생긴 새 canonical URL 30개와 Tech Notes 14개, 합계 44개를 sitemap으로 알린다.
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
- `noindex,follow`
- sitemap과 내부 링크에서는 옛 URL을 제거

Google은 0초 `meta refresh`를 permanent redirect 신호로 처리한다. 다만 Google은 같은 사이트 안의 canonical
선택 수단으로 `noindex`를 권장하지 않고 redirect 또는 `rel="canonical"`을 사용하라고 안내한다. 이동 신호가
불필요하게 섞이지 않도록 Search Console 작업 전에 다음 상태로 정리한다.

- [ ] 옛 호환 페이지 14개에서 `<meta name="robots" content="noindex,follow">`를 제거한다.
- [ ] 0초 `meta refresh`, 새 URL canonical, 새 URL로 가는 1:1 링크는 유지한다.
- [ ] 변경을 배포한 뒤 옛 URL 14개의 live HTML에 `noindex`가 없고 대상 URL이 정확한지 확인한다.

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
- `/sitemap.xml` → `200`, 50개 canonical URL(Tech Notes 배포 전 live 기준)

Search Console 작업 전 아래 항목을 다시 확인한다.

- [ ] GitHub Pages 배포가 기준 변경 `f300f26`을 포함한다.
- [ ] 옛 URL의 `noindex` 제거와 ytdl `lastmod` 정정 후속 commit을 기록한다: `____________`.
- [ ] GitHub Pages live 배포가 기록한 후속 commit까지 반영한다.
- [ ] 새 URL 또는 이동 후 canonical URL 44개가 모두 `200`이다.
- [ ] 옛 제품 URL 14개가 각각 대응하는 새 URL 하나로 직접 이동하며 `noindex`가 없다.
- [ ] 새 페이지에 `noindex`가 없다.
- [ ] 새 페이지의 canonical과 `hreflang`이 `/apps/`, `/manual/`, `/tech-notes/` 구조를 사용한다.
- [ ] `robots.txt`가 `sitemap.xml`을 계속 가리킨다.
- [ ] Google 소유권 확인 파일 `googlec8773d84a9d25688.html`을 삭제하지 않았다.

## 4. Search Console에서 수행할 작업

### 4.1 속성

- [ ] 기존 URL 접두어 속성 `https://droidactor.github.io/`를 연다.
- [ ] 소유권이 계속 확인됨인지 본다.
- [ ] 새 속성을 만들지 않는다.
- [ ] 주소 변경 도구를 실행하지 않는다.

### 4.2 Sitemap

Google은 URL 이동 후 새 canonical URL을 담은 sitemap을 제출하라고 권장하며, 많은 새 URL의 crawl 요청에는
개별 URL 검사보다 sitemap이 적합하다고 안내한다.

- [ ] `https://droidactor.github.io/sitemap.xml`의 실제 내용이 64 URL인지 확인한다.
- [ ] sitemap에는 옛 제품 URL 14개가 없고 새 canonical URL만 있는지 확인한다.
- [ ] 중요한 내용·구조·link가 바뀐 모든 URL의 `lastmod`가 실제 최종 변경일인지 양방향으로 확인한다.
- [ ] `/apps/yt-downloader/`, `/ko/apps/yt-downloader/`를 포함해 이번에 전역 탐색 링크가 바뀐 URL의
      `lastmod`가 실제 변경일 `2026-08-14`인지 확인하고 배포한다.
- [ ] Search Console의 기존 sitemap 행을 **삭제하지 않는다.** 삭제하면 이전 처리 이력만 잃는다.
- [ ] 기존 행의 상태·마지막으로 읽은 날짜·발견된 페이지 수를 기록한다.
- [ ] Tech Notes 배포 후 마지막으로 읽은 날짜가 2026-08-14 이후이고 발견된 페이지가 64이면 추가
      제출하지 않는다.
- [ ] 7일 뒤에도 이전 내용 34개를 기준으로 머물거나 `가져올 수 없음`이면, 기존 행을 삭제하지 않은 채
      같은 `sitemap.xml`을 한 번 제출한다.
- [ ] 이후 반복 제출하지 않고 상태 변화를 기다린다.

정상 목표:

- 상태: `성공`
- 발견된 페이지: `64`
- sitemap에 포함된 URL: 새 canonical URL만 표시

근거:

- [Google: Sitemap 작성·제출](https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap)
- [Google: URL 검사 및 다수 URL 재색인](https://support.google.com/webmasters/answer/9012289)

### 4.3 URL 검사 → 색인 생성 요청

44개를 한꺼번에 수동 요청하지 않는다. Sitemap이 기본 경로이고, URL 검사는 중요한 URL의 발견을
앞당기거나 비색인 원인을 진단하는 보조 수단이다. Google은 속성별 일일 요청 제한이 있다고 명시한다.

이 사이트에서 2026-08-10~11에 확인한 실행 규칙을 그대로 적용한다.

- KST 09:00 이후 시작한다.
- 하루 10개를 기준으로 진행한다.
- 할당량 초과 메시지가 나오면 그날은 즉시 중단한다.
- 같은 URL을 반복 요청하지 않는다.
- 요청 전 반드시 `실제 URL 테스트`를 통과시킨다.

#### 우선순위 0 — 즉시 요청: 허브와 출시 앱의 새 제품 URL, 10개

- [ ] `https://droidactor.github.io/apps/`
- [ ] `https://droidactor.github.io/ko/apps/`
- [ ] `https://droidactor.github.io/manual/`
- [ ] `https://droidactor.github.io/ko/manual/`
- [ ] `https://droidactor.github.io/apps/bt-keyboard/`
- [ ] `https://droidactor.github.io/ko/apps/bt-keyboard/`
- [ ] `https://droidactor.github.io/apps/wifi-scout/`
- [ ] `https://droidactor.github.io/ko/apps/wifi-scout/`
- [ ] `https://droidactor.github.io/apps/lgtv/`
- [ ] `https://droidactor.github.io/ko/apps/lgtv/`

#### 우선순위 1 — 조건부 요청: 출시 앱 매뉴얼과 나머지 Bluetooth 제품 URL, 10개

먼저 sitemap에 맡긴다. 7~14일 뒤에도 URL Inspection에서 미발견 또는 비색인이면 제외 사유와 live test를
확인하고, 기술 문제를 고친 뒤 필요한 URL만 요청한다.

- [ ] `https://droidactor.github.io/manual/bt-keyboard/`
- [ ] `https://droidactor.github.io/ko/manual/bt-keyboard/`
- [ ] `https://droidactor.github.io/manual/wifi-scout/`
- [ ] `https://droidactor.github.io/ko/manual/wifi-scout/`
- [ ] `https://droidactor.github.io/manual/lgtv/`
- [ ] `https://droidactor.github.io/ko/manual/lgtv/`
- [ ] `https://droidactor.github.io/apps/bt-ppt/`
- [ ] `https://droidactor.github.io/ko/apps/bt-ppt/`
- [ ] `https://droidactor.github.io/apps/bt-mouse/`
- [ ] `https://droidactor.github.io/ko/apps/bt-mouse/`

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

- [ ] `https://droidactor.github.io/tech-notes/` — 우선 요청
- [ ] `https://droidactor.github.io/ko/tech-notes/` — 우선 요청
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

수동 URL 검사 대상으로 선택한 URL에서 확인할 값:

- [ ] Page fetch: 성공
- [ ] Crawl allowed: 예
- [ ] Indexing allowed: 예
- [ ] User-declared canonical: 검사한 새 URL과 동일
- [ ] 실제 URL 테스트: 성공
- [ ] 색인 요청 대상으로 선별한 URL만 `색인 생성 요청` 성공을 확인

### 4.4 옛 URL 확인

옛 URL은 sitemap에 다시 넣거나 색인 생성 요청하지 않는다. Google이 기존 URL을 다시 crawl하면서 이동
신호를 읽도록 계속 제공한다.

- [ ] 영문 대표 `/bt-keyboard/`를 URL 검사하여 새 `/apps/bt-keyboard/`로 이동하는지 확인한다.
- [ ] 국문 대표 `/ko/bt-keyboard/`를 URL 검사하여 새 `/ko/apps/bt-keyboard/`로 이동하는지 확인한다.
- [ ] 기존에 색인됐던 나머지 옛 제품 URL도 대응하는 새 URL로 1:1 연결되는지 표본 확인한다.
- [ ] 옛 URL에 대한 삭제 요청을 만들지 않는다.
- [ ] 옛 URL 호환 페이지를 최소 2027-08-14까지 삭제하지 않는다.

URL 이동은 Googlebot이 옛 URL과 새 URL을 각각 crawl해야 URL 단위로 처리된다. Google 공식 문서는 redirect를
일반적으로 최소 1년 유지하라고 권장한다.

## 5. 외부 링크 갱신

내부 링크와 sitemap은 이미 새 URL로 바뀌었다. 외부에서 옛 제품 URL을 직접 가리키는 링크가 있으면 새
canonical URL로 바꾸면 redirect 의존도를 줄일 수 있다.

- [ ] Search Console의 `링크` 보고서에서 옛 제품 URL로 들어오는 외부 링크를 확인한다.
- [ ] 직접 수정 가능한 Blogger·Naver·GitHub README·프로필 링크가 있으면 `/apps/<app>/`로 바꾼다.
- [ ] Google Play Console의 스토어 등록정보가 제품 상세 URL을 직접 사용한다면 새 `/apps/<app>/`로 바꾼다.
- [ ] 개발자 웹사이트가 root `https://droidactor.github.io/`이면 변경하지 않는다.
- [ ] 개인정보 처리방침 URL `/#privacy-*`, `/ko/#privacy-*`는 변경하지 않는다.

## 6. 관찰 일정과 완료 조건

### 배포 직후

- [ ] live `200`, redirect, canonical, sitemap 64개를 확인한다.
- [ ] Search Console sitemap의 현재 상태를 기록한다.
- [ ] 우선순위 0 URL 검사를 수행한다.

### 7일 후

- [ ] sitemap의 마지막 읽은 날짜가 이동 이후로 갱신됐는지 확인한다.
- [ ] 발견된 페이지 수가 64로 바뀌었는지 확인한다.
- [ ] Page indexing 보고서를 해당 sitemap으로 필터링해 색인됨·비색인 수와 제외 사유를 기록한다.
- [ ] 우선순위 1·2 URL의 발견 여부·색인 상태·마지막 crawl 날짜를 확인하고 요청 대상을 선별한다.
- [ ] Page indexing에서 redirect 오류·soft 404·canonical 불일치가 늘지 않았는지 확인한다.

### 14일 후

- [ ] 새 제품 URL 14개 중 Google이 발견한 수를 기록한다.
- [ ] 새 매뉴얼 URL 12개와 허브 4개 중 Google이 발견한 수를 기록한다.
- [ ] 새 Tech Notes URL 14개 중 Google이 발견한 수를 기록한다.
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

- [ ] sitemap 상태가 성공이고 발견된 페이지가 64이다.
- [ ] 이 64는 sitemap에서 파싱한 고유 URL 수이며, crawl 또는 index 완료 수가 아님을 확인했다.

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
- `googlec8773d84a9d25688.html`을 삭제하지 않는다.

## 8. 공식 참고 자료

- [Site Moves and Migrations](https://developers.google.com/search/docs/crawling-indexing/site-move-with-url-changes)
- [Redirects and Google Search](https://developers.google.com/search/docs/crawling-indexing/301-redirects)
- [Change of Address tool](https://support.google.com/webmasters/answer/9370220)
- [URL Inspection tool](https://support.google.com/webmasters/answer/9012289)
- [Build and submit a sitemap](https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap)
- [Sitemaps report](https://support.google.com/webmasters/answer/7451001)
- [Canonicalization](https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls)
- [Removals tool](https://support.google.com/webmasters/answer/9689846)
