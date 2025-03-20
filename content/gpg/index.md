---
date: '2025-03-20'
draft: false

showDateOnlyInArticle : false
showHeadingAnchors : false
layoutBackgroundHeaderSpace: false
showDate: false
showViews: false
showLikes: false
showDateUpdated: false
showAuthor: false
showHero: false
heroStyle: "background" # valid options: basic, big, background
showBreadcrumbs: false
showDraftLabel: false
showEdit: false
editAppendPath: true
seriesOpened: false
showPagination: false
invertPagination: false
showReadingTime: false
showTableOfContents: true
showTaxonomies: false
showAuthorsBadges: false
showWordCount: false
showSummary: false
sharingLinks: false
showRelatedContent: false
disableComments: true
---

{{< typeit
  tag=h1
  lifeLike=true >}}
GPG Public Key Information
{{< /typeit >}}

This document explains how to obtain and verify my GPG public key. I use this key to sign my git commits and emails, ensuring my authenticity.

## Public Key

**Key ID**: 0x3C20AD5E4FF1B301

**Fingerprint**: E5C4 27DD 2F2A EF51 E356 1017 3C20 AD5E 4FF1 B301

**Email**: ronny@roethof.net 

Search your favourite key server for the fingerprint above, or download directly from here.

* [https://roethof.net/rroethof.asc](https://roethof.net/rroethof.asc)
* [https://keys.openpgp.org](https://keys.openpgp.org/search?q=E5C427DD2F2AEF51E35610173C20AD5E4FF1B301)


## Proof of identity

I have uploaded a signed proof here so you can verify my key.

1) Install my public key.
```
curl -s https://roethof.net/rroethof.asc | gpg --import
```

2) Download my proof and signature to verify. 
```
curl -s https://roethof.net/gpg_proof.txt.asc | gpg --verify - <(curl -s https://roethof.net/gpg_proof.txt)

```

This should give you an output like:

```
gpg: Signature made Thu 20 Mar 2025 06:44:43 PM CET
gpg:                using EDDSA key E5C427DD2F2AEF51E35610173C20AD5E4FF1B301
gpg: Good signature from "Ronny Roethof <ronny@roethof.net>" [ultimate]
```
