# droidactor.github.io

Developer site for the droidactor Android apps — app listing, support contact, privacy policy,
and the host for `app-ads.txt`.

`https://droidactor.github.io/` 로 게시되는 GitHub Pages 사이트다. Play Console · App Store Connect 에
**개발자 웹사이트**로 등록하는 주소이며, AdMob 의 `app-ads.txt` 크롤러가 읽는 도메인 루트도 여기다.

## 파일

| 파일 | 역할 |
|---|---|
| `index.html` | 앱 목록 + 지원 연락처 + 개인정보 처리방침. 자기완결(외부 CDN·폰트·스크립트 없음), 한/영 토글, 다크·라이트 대응 |
| `app-ads.txt` | AdMob 판매자 선언. **AdMob 콘솔이 생성한 줄을 그대로** 넣는다 — 손으로 만들지 않는다 |
| `.nojekyll` | GitHub Pages 의 Jekyll 빌드 우회. 파일이 손대지 않은 채 그대로 서빙되게 한다 |

## 등록하는 URL

| 용도 | URL |
|---|---|
| 개발자 웹사이트 | `https://droidactor.github.io/` |
| 개인정보 처리방침 | `https://droidactor.github.io/#privacy` |
| 앱별 개인정보 처리방침 | `#privacy-bthid` · `#privacy-ppt` · `#privacy-wifi` · `#privacy-ssh` · `#privacy-ytdl` |
| app-ads.txt 검증 | `https://droidactor.github.io/app-ads.txt` |

`app-ads.txt` 는 **도메인 루트에 있어야 한다.** 그래서 이 리포 이름이 `droidactor.github.io` 여야 하고
(User site → 루트 서빙), 이름이 다르면 `/<리포명>/app-ads.txt` 로 밀려 검증이 실패한다.

크롤러의 출발점은 **스토어 앱 페이지의 "개발자 웹사이트" 필드**다. 그 칸이 비어 있으면 파일이 정상이어도
검증되지 않는다.

## 남은 일

- [ ] 앱이 출시되는 대로 카드의 `badge soon` 을 스토어 링크로 교체.

지원·개인정보 문의 주소는 `droidactor@gmail.com` 이다(`index.html` 의 Support 섹션과 §8).
개인정보 처리방침의 연락처는 Play 정책상 필수 항목이므로 비워두지 않는다.

## 고칠 때

- **앱을 추가하면** 카드(`<article class="card">`)와 개인정보 §7 의 앱별 항목(`<div class="policy" id="privacy-…">`)을
  짝으로 추가한다. 새 권한이 생기면 권한 표(§4)에 행도 넣는다.
- **개인정보 처리방침을 고치면** 섹션 머리의 "최종 갱신 / Last updated" 날짜를 함께 고친다. 두 언어 모두다.
- 권한 설명은 추측하지 않고 각 앱의 `AndroidManifest.xml` 을 근거로 쓴다. 위치 권한 없음,
  `NEARBY_WIFI_DEVICES` 의 `neverForLocation` 처럼 심사에서 문제되는 항목은 매니페스트가 근거다.
- 앱 목록·패키지명·출시 상태의 정본은 이 리포가 아니라 `MyApps/Mobile/apps-map.md` 다.

## 확인

로컬은 `index.html` 을 브라우저로 열면 된다(푸터의 `/app-ads.txt` 링크만 `file://` 에서 깨진다).
게시 설정은 `Settings → Pages → Source = Deploy from a branch`, `main` / `/ (root)`.

AdMob 콘솔의 app-ads.txt 상태가 "확인됨" 으로 바뀌는 데 하루 이상 걸린다. 반영이 늦다고 파일을 계속
고치지 말고, `https://droidactor.github.io/app-ads.txt` 가 브라우저에 그대로 보이는지만 확인한다.
