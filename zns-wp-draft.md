



    
    
    
    
    
    
    
    
    
    
    
    Zcash Name Service - HackMD
    
	
	
    

    
  (() => {
    const resolveTheme = (preferredTheme) => {
      if (preferredTheme) return preferredTheme
      if (
        typeof window.matchMedia === 'function' &&
        window.matchMedia('(prefers-color-scheme: dark)').matches
      ) {
        return 'dark'
      }
      return 'light'
    }

    const isPrint = new URL(window.location.href).searchParams.get('print') === 'true'
    const uiTheme = resolveTheme('dark' || null)
    const contentTheme = isPrint ? 'light' : resolveTheme('' || null)

    window.__HMD_IS_PRINT_MODE__ = isPrint
    document.documentElement.setAttribute('theme', uiTheme)
    window.__HMD_INITIAL_UI_THEME__ = uiTheme
    window.__HMD_INITIAL_CONTENT_THEME__ = contentTheme
  })()


    

  window.domain = 'hackmd.io'
  window.urlpath = ''
  window.debug = false || window.localStorage.getItem('HMD_DEBUG_FLAG') === 'true'
  window.version = '1.3.0'
  window.brand = 'HackMD'

  
  window.NOTE_ID = 'vr9F90dXTnOOf-d7WVMX0Q'
  

  
  window.PUBLISH_TYPE = 'view'
  

  window.GOOGLE_DRIVE_API_KEY = 'AIzaSyAHmcP5gL_64ZafuAYOvJruFAIaYgHQaY4'
  window.GOOGLE_DRIVE_CLIENT_ID = '65857506266-76uhhee8se8dgs1i0q8fhtj1prg0ar27.apps.googleusercontent.com'
  window.DROPBOX_APP_KEY = 'rdoizrlnkuha23r'
  
  window.PLANTUML_SERVER = 'https://ptuml.hackmd.io'

  window.ASSET_URL = 'https://assets.hackmd.io'

  window.USER_CAN_CREATE_TEAM = true
  window.USER_CAN_DELETE_ACCOUNT = true
  window.USER_DELETE_ACCOUNT_VIA_EMAIL = true
  window.PAYMENT_ENABLED = true
  window.PAYMENT_PROMOTION_BANNER_ENABLED = false
  window.GITHUB_SYNC_ENABLED = true
  window.GITLAB_SYNC_ENABLED = false
  window.GITLAB_SYNC_BASE_URL = ''
  window.VCS_SYNC_MODE = 'github'
  window.VCS_PROVIDER_NAME = 'GitHub'
  window.FREE_TEAM_NUM = 20
  window.FREE_TEAM_MEMBER_NUM = 3
  window.FREE_PUBLIC_TEAM_NUM = 10
  window.FOLDER_ENABLE = true

  
  window.EE_SITE_ENABLE = false
  window.EE_SITE_NAME = 'false'
  window.EE_SITE_LINK = 'false'
  window.EESITE_INFO = false
  window.ENTERPRISE_DISCOVERY_ENABLE = false
  window.ENTERPRISE_DISCOVERY_TEAM = true
  window.ENTERPRISE_DISCOVERY_NOTE = true
  window.ENTERPRISE_DISCOVERY_VIEW_PERMISSION = 'guest'
  
  window.ALLOW_ANONYMOUS = true
  window.ALLOW_ANONYMOUS_EDIT = false
  window.ALLOW_DOWNLOAD_PDF = true
  window.PUBLIC_OVERVIEW = false
  window.INTERNAL_PUBLIC_OVERVIEW = false
  window.FULL_TEXT_SEARCH_ENABLE = false
  window.ALGOLIA_SEARCH_ENABLE = true
  window.MARKETING_EMAIL_ENABLE = true
  window.EMAIL_INVITATION_ENABLE = true
  
  
  
    window.WALLET_CONNECT_PROJECT_ID = '91d6fa182b725b5895a17a170a5878c1'
  
  window.API_MANAGEMENT_UI_ENABLE = true
  window.FEEDBACK_UI_ENABLE = true
  window.PUBLISH_ENABLE = true

  

  
  window.SHOW_OVERVIEW = false
  

  
  window.MENTIONS = {}
  

  
  window.MENTION_ANCHORS = []
  

  
  window.COMMENT_ANCHORS = []
  

  
  window.IS_OWNER = false
  

  
  window.IS_TEAM_ADMIN = false
  

  
  window.IS_TEAM_MEMBER = false
  

  
  window.IS_INVITEE_ADMIN = false
  

  
  window.USER_PROFILE = '%7B%22name%22%3A%22Guest%20Kim%22%7D'
  

  
  window.VERSION_TIME = '1787585187365'
  

  
  window.canEdit = false
  

  

  
  window.canWriteComment = true
  

  
  window.canHideComment = false
  

  window.TRASH_NOTE_DELETE_AFTER_FREE = 3
  window.TRASH_NOTE_DELETE_AFTER_PAID = 30

  
    window.ENABLED_PREVIEW_FEATURE = {}
  

  
    window.ACTIVE_PREVIEW_FEATURE = ["beta-slide-preview","beta-note-insights","beta-neo-book","mcp-oauth"]
  

  

  

  

  

  
    window.IS_OWNER_UPGRADED = false
  

  
    window.IMGUR_FALLBACK_CDN = 'https://imgur-backup.hackmd.io'
  

  
    window.YAML_METADATA_ENABLED = false
  

  
    window.NOTE_CAPACITY_LIMIT = 50
  

  
    window.DOCUMENT_MAX_LENGTH = 100000
  

  
    window.SOCIAL_NETWORK_FEATURES_ENABLED = true
  

  
    window.PUBLISHMENT_MODERATION_ENABLED = true
  

  
    window.COMMENT_ENABLED = true
  

  
    window.COMMENT_PERMISSION = "everyone"
  

  window.SUGGEST_EDIT_ENABLED = true
  
    window.SUGGEST_EDIT_ENABLED = true
  

  
    window.SUGGEST_EDIT_PERMISSION = "signed_in_users"
  
  
    window.canWriteSuggestEdit = false
  

  window.CITATION_ENABLED = true

  window.NOTE_FROM_COMMENT_ENABLED = true

  
    window.NOTE_FEATURES = {"emoji-reply":"signed_in_users","citation":"disabled"}
  

  
    window.REALTIME_CLIENT_WITH_CREDENTIALS = false
  

  

  
    window.PREFERRED_UI_THEME = "dark"
  

  

  
    window.CUSTOM_STYLE_ENABLED = "true"
  

  

  
    window.ITERABLE_ENABLED = false
  
  
    window.ITERABLE_API_KEY = "c2c36a44c2614fb19aa3b46d660bbce2"
  

  
    window.CUSTOMERIO_ENABLED = true
  
  
    window.CUSTOMERIO_WRITE_KEY = "90283c80a6498bb8d1ee"
  
  
    window.CUSTOMERIO_SITE_ID = "9947d0d46b7ece25dea7"
  

  
    window.TEXT_SELECTION_CHANGED = false
  

  
    window.CAN_VIEW_HISTORY_AT_REVISION = false
  

  
    window.GUIDED_COMMENT_ENABLED = true
  

  
    window.ENCODED_SESSION_ID = "ev4JfSIo2d7rCerKcfhKK8aKVs4WZ8qbt+uT9c2C93c="
  

  
    window.COMMUNITY_ENABLED = true
  

  
    window.NOTE_INSIGHTS_DEBUG_API_ENABLED = false
  

  

  



    

(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-KLW9Z3');



    






    



    




    
    







    



    
    







    














     
    


	
	
	


    


    
  window.__shouldIgnoreTracker = function() {
    const isDebug = window.debug === true
    const isLocal = /^localhost$|^127(\.[0-9]+){0,2}\.[0-9]+$|^\[::1?\]$|^local\.localhost$/.test(location.hostname) || location.protocol === 'file:'
    const isAutomation = Boolean(window._phantom || window.__nightmare || window.navigator.webdriver || window.Cypress)
    return isDebug || isLocal || isAutomation
  }





  window.plausible = window.plausible || function() { (window.plausible.q = window.plausible.q || []).push(arguments); }
  const keyboardWhiteList = ['a', 'span', 'button']

  function getTaggedEventAttributes (e) {
    const eventAttrs = { name: null, props: {} }
    if (!e || !e.classList) return eventAttrs
    const psEvent = /plausible-event-(.+)(=|--)(.+)/
    for (const className of [...e.classList]) {
      const [, key, , val] = className.match(psEvent) || []
      if (!key || !val) continue
      const value = val.replace(/\+/g, ' ')
      switch (key.toLowerCase()) {
        case 'name':
          eventAttrs.name = value
          break
        default:
          eventAttrs.props[key] = value
          break
      }
    }
    return eventAttrs
  }

  function shouldIgnore () {
    return window.__shouldIgnoreTracker() || window.localStorage.getItem('plausible_ignore') === 'true'
  }

  function handler (e) {
    if (!window.plausible) return
    if (!e.target || !('className' in e.target)) return
    const ele = e.target

    const eventAttrs = getTaggedEventAttributes(ele)
    if (!eventAttrs.name) return
    if (ele?.href) eventAttrs.props.url = ele.href

    if (shouldIgnore()) {
      if (window.debug) logDebugEventMsg(eventAttrs)
      return
    }
    window.plausible(eventAttrs.name, { props: eventAttrs.props })
  }

  function logDebugEventMsg (eventAttrs) {
    console.warn(
      `Ignoring Event: "${eventAttrs.name}"`,
      eventAttrs,
    )
  }

  function keydownHandler (e) {
    if (e.key !== 'Enter') return
    if (e.target.nodeName.toLowerCase() === 'input') {
      switch (e.target.type.toLowerCase()) {
        case 'submit':
        case 'button':
        case 'reset':
        case 'checkbox':
        case 'radio':
        case 'file':
        case 'image':
        case 'color':
          break
        default:
          return
      }
    } else if (!keyboardWhiteList.includes(e.target.nodeName.toLowerCase())) {
      return
    }
    handler(e)
  }

  document.addEventListener('mousedown', handler)
  document.addEventListener('keydown', keydownHandler)


    

  window.publishProps = JSON.parse(`{"isOwnerAnonymous":false,"isOwnedByTeam":false,"ownerInfo":{"name":"Zechariah","path":"zec","avatarUrl":"https%3A%2F%2Fuploads-public.hackmd.io%2Fupload_22608bc420438caefb6f792826091589.png","description":null},"isPublished":false,"createTime":1786688669714,"updateTime":1787585187365,"vcsSyncMode":"github","vcsProviderName":"GitHub","canEdit":false,"hardBreaks":true,"onlyOwnerCanEdit":false,"isCommentEnabled":true,"likedCount":0,"isNotificationEnabled":true,"notificationType":"never","hasEmail":false,"canWriteComment":true,"viewCount":49,"markdown":"%0A%5BZNS%20Audit%20Plan%20-%20Aug%2FSept%5D(https%3A%2F%2Fhackmd.io%2F%40zec%2Fzns-audit-plan)%0A%5BAdditions%20to%20the%20ZNS%20Protocol%20Whitepaper%5D(%2Fl_3XPiO5ReOA4s9o31YdDg)%0A%0A%23%20Zcash%20Name%20Service%0A%0A%0A%23%23%20~~A%20Deterministic%20Name%20Registry%20over%20the%20Ironwood%20Transaction%20Log~~%20A%20Deterministic%2C%20Attested%20Name%20Registry%20on%20Zcash%0A%0A%60%60%60Note%20to%20author%20about%20title%20(do%20not%20include%20in%20paper)%3A%0ADeterministic%20captures%20Resolver%20state%20derivation.%0AAttested%20captures%20the%20Mint's%20TEE-based%20authorization%20and%20policy%20enforcement.%0AName%20Registry%20states%20exactly%20what%20the%20protocol%20is.%0Aon%20Zcash%20is%20broader%20and%20more%20durable%20than%20tying%20the%20title%20to%20%E2%80%9Cthe%20Ironwood%20transaction%20log.%E2%80%9D%0AIronwood%20can%20then%20be%20introduced%20precisely%20in%20the%20abstract%20and%20architecture%20sections.%0A%60%60%60%0A**craftsoldier**%20%20%0A%5Bgithub.com%2Fcraftsoldier%5D(https%3A%2F%2Fgithub.com%2Fcraftsoldier)%20%C2%B7%20%5Bjulian%40zcash.me%5D(mailto%3Ajulian%40zcash.me)%0A%0A**Zechariah**%20%20%0A%5Bgithub.com%2FZcashUsersGroup%5D(https%3A%2F%2Fgithub.com%2FZcashUsersGroup)%20%C2%B7%20%5Bjames%40zcash.me%5D(mailto%3Ajames%40zcash.me)%0A%0A*Protocol%20draft%20%E2%80%94%20August%2024%2C%202026*%0A%0A%7C%20Field%20%7C%20Value%20%7C%0A%7C---%7C---%7C%0A%7C%20Status%20%7C%20Draft%20%7C%0A%7C%20Category%20%7C%20Standards%20Track%20%7C%0A%7C%20Created%20%7C%20August%2024%2C%202026%20%7C%0A%7C%20License%20%7C%20MIT%20%7C%0A%7C%20Discussion%20%7C%20%5Bgithub.com%2Fcraftsoldier%2Fzns-whitepaper%5D(https%3A%2F%2Fgithub.com%2Fcraftsoldier%2Fzns-whitepaper)%20%7C%0A%0A%23%23%20Abstract%0A%0AZcash%20payments%20use%20encoded%20addresses%2C%20but%20Zcash%20consensus%20does%20not%20assign%20human-readable%20names%20to%20them.%20Existing%20on-chain%20naming%20systems%20cannot%20be%20ported%20to%20Zcash%3A%20transparent%20registries%20such%20as%20Namecoin%20publish%20the%20namespace%20in%20the%20clear%2C%20leaking%20the%20address%20graph%20Zcash%20exists%20to%20hide%3B%20contract-based%20registries%20such%20as%20ENS%20require%20general-purpose%20on-chain%20state%20that%20Zcash%20consensus%20does%20not%20provide.%20The%20Zcash%20Name%20Service%20(ZNS)%20maps%20each%20Zcash%20name%20to%20a%20Unified%20Address%20over%20the%20ordinary%20Zcash%20transaction%20log%3A%20each%20binding%20is%20recorded%20in%20the%20memo%20of%20an%20Ironwood%20action%2C%20decryptable%20with%20the%20Name%20Note%20account%E2%80%99s%20published%20full%20viewing%20key%2C%20and%20anchored%20by%20an%20Ironwood%20note%20commitment%20derived%20from%20the%20same%20tuple.%20Zcash%20consensus%20supplies%20canonical%20order%20and%20finality%3B%20a%20deterministic%20reducer%20derives%20the%20registry%3B%20the%20bound%20Unified%20Address%20inherits%20Ironwood%20shielding.%20Authorization%20is%20delivered%20by%20an%20attested%20Mint%3B%20a%20future%20off-chain%20zero-knowledge%20name%20circuit%20would%20replace%20that%20assumption%20with%20a%20proof.%0A%0A**Status.**%20This%20document%20is%20a%20work%20in%20progress.%20Sections%20explicitly%20marked%20Open%20or%20Provisional%20are%20not%20interoperability%20requirements.%20Sections%20marked%20Fixed%20state%20normative%20requirements%20backed%20by%20the%20cited%20assumptions.%20An%20implementation%20cannot%20infer%20a%20protocol%20rule%20from%20an%20unresolved%20item.%20The%20key%20words%20MUST%2C%20MUST%20NOT%2C%20SHOULD%2C%20and%20MAY%20are%20to%20be%20interpreted%20as%20described%20by%20BCP%2014%20only%20when%20they%20appear%20in%20uppercase%20%5B5%5D.%0A%0A%23%23%201%20Motivation%0A%0AZcash%20addresses%20are%20long%20encoded%20strings.%20A%20naming%20system%20maps%20these%20strings%20to%20human-readable%20labels%2C%20but%20this%20requires%20enforcing%20rules%20about%20which%20names%20are%20claimed%20and%20who%20controls%20them.%20Zcash%20consensus%20tracks%20unspent%20coins.%20Lacking%20a%20virtual%20machine%20to%20run%20logic%20and%20a%20global%20state%20tree%20to%20store%20variables%2C%20it%20cannot%20evaluate%20a%20naming%20policy.%20To%20bypass%20this%20limitation%2C%20ZNS%20separates%20the%20execution%20of%20the%20naming%20policy%20from%20the%20permanent%20public%20record.%20A%20single%20party%2C%20the%20Mint%2C%20executes%20the%20policy%20off-chain.%20When%20a%20request%20passes%2C%20the%20Mint%20writes%20the%20resulting%20name%20binding%20into%20the%20512-byte%20memo%20field%20of%20a%20shielded%20Zcash%20transaction.%20Zcash%20consensus%20seals%20the%20transaction%20into%20a%20block%2C%20locking%20the%20binding%20into%20a%20permanent%2C%20chronological%20order.%20A%20Resolver%20looking%20up%20a%20name%20downloads%20the%20Zcash%20block%20headers%2C%20uses%20a%20published%20viewing%20key%20to%20decrypt%20the%20Mint%E2%80%99s%20memos%2C%20and%20reads%20the%20bindings%20in%20the%20exact%20order%20consensus%20finalized%20them.%20The%20Mint%20issues%20names%2C%20but%20the%20accumulated%20work%20of%20the%20Zcash%20blockchain%20prevents%20it%20from%20altering%20or%20erasing%20previously%20recorded%20bindings.%0A%0A%23%23%202%20Architecture%0A%0ATo%20guarantee%20the%20globally%20unique%20mapping%20of%20human-readable%20names%20to%20Zcash%20addresses%2C%20a%20naming%20system%20requires%20an%20agreed-upon%20history%20of%20requests%20to%20register%2C%20modify%2C%20or%20release%20names%2C%20a%20strict%20set%20of%20rules%2C%20and%20a%20resulting%20registry%20of%20name%20bindings.%20ZNS%20treats%20this%20registry%20as%20derived%20state%20by%20using%20Zcash%20exclusively%20for%20the%20history%20of%20these%20requests%2C%20executing%20rules%20off-chain%2C%20and%20binding%20their%20accepted%20results%20on-chain.%0A%0A%23%23%23%202.1%20System%20Components%0A%0AThe%20protocol%20relies%20on%20three%20distinct%20components%3A%0A%0A-%20**The%20Mint.**%20The%20authoritative%20off-chain%20program%20that%20evaluates%20the%20naming%20policy.%20It%20runs%20inside%20a%20Trusted%20Execution%20Environment%20(TEE)%2C%20with%20its%20authority%20bound%20to%20approved%20protocol%20code%20through%20remote%20attestation.It%20uses%20its%20own%20Zcash%20node%20to%20read%20chain%20state%20independently.%0A-%20**The%20Name%20Note.**%20An%20Ironwood%20output%20used%20to%20record%20a%20name%20transition%20on-chain.%20%0A-%20**The%20Resolver.**%20A%20permissionless%20client%20that%20reads%20the%20canonical%20sequence%20of%20Zcash%20transactions%2C%20verifies%20Name%20Notes%20and%20deterministically%20derives%20registry%20state.%0A%0A%23%23%23%202.2%20Independence%20of%20Facts%0A%0AThe%20security%20of%20the%20derived%20state%20relies%20on%20six%20distinct%20properties.%20The%20Resolver%20verifies%20publicly%20reconstructible%20properties%20directly%20and%20relies%20on%20Mint%20attestation%20for%20policy%20checks%20that%20are%20not%20publicly%20reconstructible.%0A%0A-%20**Zcash%20validity%3A**%20The%20transaction%20satisfies%20Zcash%20consensus.%0A-%20**Mint%20authorization%3A**%20The%20recognized%20Mint%20spending%20key%20authorized%20the%20transaction.%0A-%20**TEE%20attestation%3A**%20The%20recognized%20Mint%20identity%20executed%20the%20approved%20enclave%20code.%0A-%20**Name%20Note%20verification%3A**%20The%20transition%20tuple%20encoded%20in%20a%20Name%20Note%20matches%20its%20Ironwood%20note%20commitment.%0A-%20**User%20authorization%3A**%20The%20attested%20Mint%20enforces%20the%20authorization%20procedure%20defined%20in%20Section%205.%20%0A-%20**State%20derivation**%3A%20Resolvers%20reading%20the%20canonical%20Zcash%20chain%20under%20identical%20protocol%20parameters%20derive%20the%20same%20registry%20state.%0A%0A%23%23%203%20Name%20Notes%0A%0A%0AA%20Name%20Note%20is%20an%20Ironwood%20output%20whose%20memo%20records%20a%20name%20transition%20by%20encoding%20the%20type%20of%20name%20change%2C%20the%20name%2C%20the%20associated%20Unified%20Address%20when%20applicable%2C%20the%20expiration%20value%2C%20and%20a%20predecessor%20reference.%0A%0A%23%23%23%203.1%20Memo%20encoding%0A%0AThe%20Name%20Note%20memo%20is%20a%20512-byte%20field.%20A%20parser%20removes%20its%20maximal%20trailing%20sequence%20of%20zero%20bytes.%20The%20remaining%20bytes%20encode%20one%20transition%20in%20one%20of%20the%20following%20formats%3A%0A%0A%0A%60%60%60text%0AZNS%3Aclaim%3A%3Cname%3E%3A%3Cua%3E%3A%3Cexpires_at%3E%3A%3Cprev_rcm%3E%0AZNS%3Aupdate%3A%3Cname%3E%3A%3Cua%3E%3A%3Cexpires_at%3E%3A%3Cprev_rcm%3E%0AZNS%3Arelease%3A%3Cname%3E%3A%3Cua%3E%3Anone%3A%3Cprev_rcm%3E%0A%60%60%60%0A%20%20%20%20%0A%0AThe%20colon%20byte%20(%600x3a%60)%20separates%20fields.%20The%20%60%3Cexpires_at%3E%60%20field%20is%20either%20the%20canonical%20ASCII%20decimal%20encoding%20of%20a%20Unix%20timestamp%20in%20whole%20seconds%20or%20the%20exact%20ASCII%20bytes%20%60none%60.%20The%20value%20%60none%60%20indicates%20that%20the%20registration%20has%20no%20fixed%20expiration.%20A%20%60release%60%20MUST%20encode%20%60none%60%20as%20its%20%60expires_at%60%20value%20and%20the%20Unified%20Address%20of%20the%20binding%20being%20released%20as%20its%20%60ua%60%20value.%0A%0AThe%20%60prev_rcm%60%20field%20is%20the%2064-character%20lowercase%20hexadecimal%20encoding%20of%20the%20predecessor%20Name%20Note's%20%60rcm%60%20value.%20The%20first%20claim%20uses%2064%20zeroes.%0A%0A%23%23%23%203.2%20Transition%20representation%0A%0ATo%20derive%20the%20ZNS-specific%20note-commitment%20inputs%2C%20%24rcm_%5Csigma%24%20and%20%24%5Cpsi_%5Csigma%24%2C%20interpret%20the%20encoded%20transition%20as%20the%20tuple%0A%0A%24%24%0A%CF%83%20%3D%20(%CE%B1%2C%20n%2C%20u%2C%20e%2C%20p)%0A%24%24%0A%0A%0Awhere%3A%0A*%20%24%5Calpha%24%3A%20The%20exact%20ASCII%20bytes%20%60claim%60%2C%20%60update%60%2C%20or%20%60release%60.%0A*%20%24n%24%3A%20The%20raw%20bytes%20of%20the%20name%20field.%0A*%20%24u%24%3A%20The%20raw%20bytes%20of%20the%20%60ua%60%20field.%20%0A*%20%24e%24%3A%20The%20raw%20bytes%20of%20the%20%60expires_at%60%20field.%0A*%20%24p%24%3A%20The%2032%20raw%20bytes%20decoded%20from%20%60prev_rcm%60.%0A%0A%0A%23%23%23%203.3%20Commitment%20inputs%0A%0AZNS%20derives%20both%20commitment%20inputs%20from%20the%20same%20transition%20representation%20%24%5Csigma%24%20using%20the%20same%20hash%20construction.%20Within%20the%20hash%20construction%2C%20the%20only%20difference%20is%20the%20ASCII%20derivation%20tag%2C%20%60rcm%60%20or%20%60psi%60.%20The%20resulting%20digests%20are%20then%20reduced%20into%20different%20Pallas%20fields.%0A%0ATo%20prevent%20ambiguous%20concatenation%2C%20define%20%24LP(x)%24%20as%20the%20four-byte%20unsigned%20little-endian%20byte%20length%20of%20%24x%24%2C%20followed%20by%20%24x%24%20itself.%20Define%20the%20protocol%20domain%20tag%20%24T%24%20as%20the%2012%20ASCII%20bytes%20%60ZcashName%2Fv1%60.%20Quotation%20marks%20are%20not%20part%20of%20%24T%24.%0A%0AFor%20derivation%20tag%20%24t%24%2C%20where%20%24t%24%20is%20the%20exact%20ASCII%20byte%20string%20%60rcm%60%20or%20%60psi%60%2C%20define%3A%0A%0A%0AH_t(%CF%83)%20%3D%0ABLAKE2b-512(%0A%20%20%20%20LP(T)%20%7C%7C%20LP(t)%20%7C%7C%20LP(%CE%B1)%20%7C%7C%20LP(n)%20%7C%7C%20LP(u)%20%7C%7C%20LP(e)%20%7C%7C%20p%0A).%0A%0ABecause%20%24e%24%20is%20included%20in%20%24%5Csigma%24%2C%20both%20ZNS-specific%20commitment%20inputs%20cryptographically%20bind%20the%20%60expires_at%60%20value%20recorded%20in%20the%20Name%20Note.%0A%0AThe%20final%20%24p%24%20is%20exactly%2032%20raw%20bytes%20and%20has%20no%20length%20prefix.%20Each%20%24H_t%24%20invocation%20uses%20unkeyed%20BLAKE2b-512%20with%20a%2064-byte%20output%20and%20no%20additional%20personalization.%0A%0AThe%20two%20commitment%20inputs%20are%20then%3A%0A%0A%24%24%0Arcm_%5Csigma%20%3D%20%5Coperatorname%7BToScalar%7D(H_%7Brcm%7D(%5Csigma))%2C%0A%24%24%0A%0A%24%24%0A%5Cpsi_%5Csigma%20%3D%20%5Coperatorname%7BToBase%7D(H_%7Bpsi%7D(%5Csigma)).%0A%24%24%0A%0AThe%20value%20%24rcm_%5Csigma%24%20is%20the%20Pallas%20scalar-field%20element%20used%20as%20the%20Ironwood%20note-commitment%20randomness.%0A%0AThe%20value%20%24%5Cpsi_%5Csigma%24%20is%20the%20Pallas%20base-field%20element%20supplied%20to%20the%20Ironwood%20note%20commitment%20construction.%0A%0A%60ToScalar%60%2C%20%60ToBase%60%2C%20and%20the%20field%20types%20are%20those%20defined%20for%20Ironwood%20by%20the%20Zcash%20Protocol%20Specification%20%5B1%2C%203%5D.%20Neither%20%24rcm_%5Csigma%24%20nor%20%24%5Cpsi_%5Csigma%24%20is%20a%20raw%2064-byte%20BLAKE2b%20digest%3B%20each%20is%20the%20field%20element%20obtained%20by%20reducing%20the%20digest%20produced%20with%20its%20respective%20derivation%20tag.%20The%20canonical%20encoding%20of%20either%20field%20element%20is%20its%2032-byte%20little-endian%20field%20representation.%20ZNS%20derives%20both%20field%20elements%20from%20%24%5Csigma%24%2C%20rather%20than%20from%20the%20rseed%20derivation%20used%20by%20ordinary%20ZIP-212%20receiving%20%5B2%2C%201%5D.%0A%0AChanging%20the%20domain%20tag%2C%20a%20derivation%20tag%2C%20field%20order%2C%20length%20width%2C%20byte%20order%2C%20hash%20parameters%2C%20or%20reduction%20rule%20changes%20the%20protocol%20version%20and%20requires%20new%20test%20vectors.%0A%0A%23%23%23%203.4%20Commitment%20verification%0A%0AZNS%20changes%20the%20derivation%20of%20%24%5Cpsi%24%20and%20%24rcm%24%20but%20does%20not%20otherwise%20change%20the%20standard%20note%20commitment%20construction.%20A%20verifier%20derives%20%24%5Cpsi_%5Csigma%24%20and%20%24rcm_%5Csigma%24%20from%20the%20encoded%20transition%2C%20combines%20them%20with%20the%20candidate's%20remaining%20note%20components%20using%20the%20standard%20construction%20%5B1%2C%203%5D%2C%20and%20reconstructs%20the%20note%20commitment.%0A%0AThe%20Name%20Note%20passes%20commitment%20verification%20only%20if%20the%20reconstructed%20value%20equals%20the%20%60cmx%60%20recorded%20in%20the%20on-chain%20action.%0A%0AThis%20equality%20establishes%20only%20that%20the%20transition%20encoded%20in%20the%20memo%20is%20cryptographically%20bound%20to%20that%20output.%20It%20does%20not%20establish%20Mint%20authorization%2C%20user%20authorization%2C%20or%20the%20current%20registry%20state.%0A%0A%23%23%23%203.5%20Commitment%20test%20vector%0A%0AFor%20a%20%60claim%60%20transition%20with%20%60name%3Dalice%60%2C%20%60expires_at%3Dnone%60%2C%20and%20a%2032-byte%20zero%20predecessor.%20Key%20material%20is%20derived%20from%20the%20all-zero%2032-byte%20seed%20under%20unified%20account%20%60m%2F32'%2F133'%2F1'%60%2C%20diversifier%20index%200%2C%20external%20scope%2C%20mainnet%3A%0A%0A%7C%20Value%20%7C%20Canonical%20little-endian%20bytes%20rendered%20as%20hexadecimal%20%7C%0A%7C---%7C---%7C%0A%7C%20%60ua%60%20%7C%20%60u1897y9pzw3zk6n9twtzu2z5kpkzw3hms2c54fpyv8lnr79m73tazljkk3veaxrtwncp66lf45p3f274xy2amqckx0sraje4v835yw8q0q%60%20%7C%0A%7C%20%60g_d%60%20%7C%20%60de4338f2ab9fd8300a3a1c20dd690ce27026c6001c295d7c641a067ce809b11e%60%20%7C%0A%7C%20%60pk_d%60%20%7C%20%606df609f5710f3b5deecd4ee4b8f0173b44af6cf8918ac00269526031ba628996%60%20%7C%0A%7C%20%60psi_%CF%83%60%20%7C%20%609f8a61b860c737d4564f12c635d654b843bc7115d9dc6cf6f09e409c81b8d13e%60%20%7C%0A%7C%20%60rcm_%CF%83%60%20%7C%20%60daa928be21d0ec13b5dbb0244699dbfeba546c71591d24d7824db78e4670c504%60%20%7C%0A%0ASet%20the%20value%20to%20zero%20and%20%60rho%60%20to%2032%20bytes%20of%20%600x33%60.%20The%20resulting%20%60cmx%60%20is%20%60cc320736a0c1df1e4ffcee2b64aa73a9e6d06bb218e155a6fef422e1ecb1f70c%60.%20An%20implementation%20that%20produces%20another%20value%20is%20non-conforming.%0A%0AThe%20complete%20memo%20encoding%20of%20this%20transition%20is%3A%0A%0A%60%60%60text%0AZNS%3Aclaim%3Aalice%3Au1897y9pzw3zk6n9twtzu2z5kpkzw3hms2c54fpyv8lnr79m73tazljkk3veaxrtwncp66lf45p3f274xy2amqckx0sraje4v835yw8q0q%3Anone%3A0000000000000000000000000000000000000000000000000000000000000000%0A%60%60%60%0A%0A%23%23%204%20The%20Mint%0A%0AThe%20Mint%20is%20the%20protocol's%20single%20registrar.%20A%20Name%20Note%20establishes%20that%20a%20transition%20is%20bound%20to%20an%20Ironwood%20output%2C%20but%20whether%20the%20transition%20is%20allowed%20depends%20on%20the%20current%20registry%20state%20and%20active%20naming%20policy.%20The%20Mint%20reads%20ordered%20requests%20on%20Zcash%2C%20derives%20that%20state%2C%20applies%20the%20policy%2C%20and%20for%20each%20accepted%20request%20spends%20a%20Mint-controlled%20note%20to%20create%20the%20successor%20Name%20Note.%0A%0A%0A%23%23%23%204.1%20Authority%20bound%20to%20policy%0A%0AThe%20Mint%20spending%20key%20provides%20the%20protocol's%20Mint%20authorization.%20The%20key%20can%20create%20a%20transition%20that%20appears%20to%20have%20been%20approved%20by%20the%20Mint%20without%20applying%20the%20naming%20policy.%20The%20key%20must%20therefore%20be%20usable%20only%20by%20the%20program%20that%20evaluates%20the%20policy.%0A%0AZNS%20runs%20the%20Mint%20inside%20a%20Trusted%20Execution%20Environment%20(TEE)%20and%20uses%20remote%20attestation%20to%20bind%20the%20Mint%20key%20to%20an%20approved%20enclave%20measurement.%20This%20shifts%20trust%20in%20policy%20execution%20and%20key%20custody%20from%20the%20Mint%20operator%20to%20the%20TEE%20attestation%20system%20and%20its%20hardware%20root%20of%20trust.%0A%0A%23%23%23%204.2%20Attestation%20constraints%0A%0AThe%20Resolver%20recognizes%20Mint%20authorization%20only%20if%20the%20attestation%20establishes%20all%20of%20the%20following%3A%0A%0A1.%20The%20enclave%20code%20measurement%20is%20approved%20by%20the%20current%20ZNS%20deployment.%0A2.%20The%20enclave%20controls%20the%20recognized%20Mint%20spending%20key.%0A3.%20The%20enclave%20runs%20the%20applicable%20ZNS%20protocol%20version.%0A4.%20The%20enclave%20targets%20the%20applicable%20Zcash%20network.%0A5.%20The%20enclave%20implements%20the%20required%20protected%20persistent-state%20mechanism%20for%20replay%20prevention.%0A6.%20The%20enclave%20obtains%20canonical-chain%20Median%20Time%20Past%20from%20the%20approved%20Zcash%20node%20interface%20and%20uses%20it%20as%20the%20authoritative%20time%20source%20for%20protocol-defined%20time%20checks.%0A%0AThe%20Resolver%20rejects%20the%20Mint%20authorization%20if%20any%20condition%20fails%20or%20if%20the%20TEE%20is%20not%20running%20in%20an%20approved%20production%20security%20configuration.%20%0A%0A%0AApproved%20enclave%20measurements%2C%20attestation%20requirements%2C%20and%20the%20approved%20source%20of%20canonical-chain%20Median%20Time%20Past%20are%20deployment-specific.%20The%20exact%20attestation%20format%20and%20verification%20procedure%20depend%20on%20the%20selected%20TEE%20platform%20and%20remain%20Open%20until%20the%20deployment%20is%20fixed.%0A%0A%23%23%23%204.3%20Claim%20eligibility%0A%0ASome%20names%20may%20be%20designated%20as%20protected%20for%20a%20limited%20protection%20period%20to%20reduce%20impersonation%2C%20misleading%20claims%20of%20affiliation%2C%20and%20opportunistic%20registration%20of%20names%20associated%20with%20existing%20identities%20or%20projects.%0A%0AA%20protected%20name%20is%20temporarily%20excluded%20from%20the%20standard%20public%20claim%20process.%20During%20the%20protection%20period%2C%20a%20claim%20must%20include%20a%20valid%20access%20code%2C%20which%20the%20Mint%20verifies%20according%20to%20the%20protected-name%20policy%20before%20accepting%20the%20claim.%0A%0AAccess-code%20verification%20is%20performed%20by%20the%20Mint%20under%20the%20attested%20protected-name%20policy%20and%20is%20not%20independently%20reconstructed%20by%20the%20Resolver.%0A%0AWhen%20the%20protection%20period%20ends%2C%20an%20unclaimed%20protected%20name%20becomes%20eligible%20for%20the%20standard%20public%20claim%20process.%20Once%20a%20protected%20name%20is%20validly%20claimed%2C%20it%20is%20governed%20by%20the%20same%20transition%20and%20authorization%20rules%20as%20any%20other%20name.%0A%0A%23%23%23%204.4%20Request%20evaluation%0A%0AThe%20Mint%20evaluates%20each%20request%20against%20the%20registry%20state%20it%20derives%20from%20the%20canonical%20Zcash%20chain.%20It%20must%20use%20its%20own%20Zcash%20node%20and%20its%20own%20replay%20of%20the%20namespace%20history%20rather%20than%20rely%20on%20a%20third-party%20state%20oracle.%20The%20Mint%20obtains%20canonical-chain%20Median%20Time%20Past%20from%20that%20node%20for%20protocol-defined%20time%20checks.%0A%0AThe%20Mint%20evaluates%20each%20request%20against%20the%20following%20requirements%3A%0A%0A-%20**Namespace%20state.**%20The%20requested%20change%20must%20be%20permitted%20by%20the%20current%20state%20of%20the%20name.%0A-%20**Payment.**%20The%20request%20must%20satisfy%20the%20price%20and%20payment%20requirements%20defined%20by%20the%20active%20pricing%20policy.%0A-%20**Request%20validity.**%20The%20name%2C%20Unified%20Address%20when%20applicable%2C%20requested%20registration%20term%20or%20extension%20when%20applicable%2C%20and%20resulting%20encoded%20transition%20must%20satisfy%20the%20protocol's%20validity%20rules.%0A-%20**Lifecycle%20policy.**%20The%20request%20must%20satisfy%20the%20active%20registration%2C%20expiration%2C%20renewal%2C%20and%20liveness%20rules%20defined%20in%20Section%204.5.%0A-%20**User%20authorization.**%20An%20%60update%60%20or%20controller-requested%20%60release%60%20must%20complete%20the%20authorization%20procedure%20defined%20in%20Section%205.%20A%20lifecycle%20%60release%60%20created%20by%20the%20Mint%20to%20enforce%20expiration%20or%20liveness%20does%20not%20require%20user%20authorization.%0A%0A%0AIf%20all%20applicable%20requirements%20are%20satisfied%2C%20the%20Mint%20accepts%20the%20request%20and%20creates%20the%20resulting%20Name%20Note.%0A%0A%0A%23%23%23%204.5%20Name%20lifecycle%0A%0AZNS%20uses%20canonical-chain%20Median%20Time%20Past%20(MTP)%20rather%20than%20block%20counts%20or%20local%20system%20time%20for%20protocol-defined%20lifecycle%20periods.%20MTP%20is%20derived%20from%20Zcash%20block%20timestamps%20and%20has%20one-second%20granularity.%20It%20is%20chain-derived%20time%20rather%20than%20exact%20wall-clock%20time.%0A%0A%23%23%23%23%204.5.1%20Initial%20claims%0A%0AA%20%60claim%60%20request%20specifies%20the%20name%2C%20the%20Unified%20Address%2C%20and%20either%20a%20requested%20registration%20term%20or%20no%20fixed%20expiration.%20The%20user%20does%20not%20supply%20an%20absolute%20%60expires_at%60%20value.%0A%0AFor%20a%20fixed-term%20registration%2C%20the%20Mint%20computes%20%60expires_at%60%20by%20adding%20the%20requested%20registration%20term%20to%20the%20canonical-chain%20MTP%20of%20the%20block%20containing%20the%20accepted%20claim%20request.%0A%0AThe%20Mint%20determines%20%60expires_at%60%20from%20that%20block%20MTP%20and%20the%20requested%20registration%20term%2C%20subject%20to%20the%20active%20registration%20policy%2C%20and%20records%20the%20resulting%20value%20in%20the%20Name%20Note.%0A%0AFor%20a%20registration%20without%20a%20fixed%20expiration%2C%20%60expires_at%60%20is%20the%20exact%20ASCII%20value%20%60none%60.%0A%0AOnly%20the%20resulting%20%60expires_at%60%20value%20is%20included%20in%20the%20Name%20Note.%20The%20claim%20request's%20block%20MTP%20and%20requested%20registration%20term%20are%20policy%20inputs%20and%20are%20not%20repeated%20as%20transition%20fields.%0A%0A%23%23%23%23%204.5.2%20Expiration%0A%0AFor%20a%20fixed-term%20registration%2C%20the%20expiration%20condition%20is%20reached%20when%3A%0A%0A%20%20%20%20canonical_chain_mtp%20%3E%3D%20expires_at%0A%0AReaching%20%60expires_at%60%20does%20not%20directly%20modify%20derived%20registry%20state.%20When%20the%20expiration%20condition%20is%20reached%2C%20the%20Mint%20MUST%20create%20a%20%60release%60%20Name%20Note.%0A%0AThe%20registration%20remains%20active%20in%20derived%20registry%20state%20until%20a%20%60release%60%20Name%20Note%20is%20accepted%20on%20the%20canonical%20Zcash%20chain%2C%20subject%20to%20the%20same-block%20precedence%20rule%20defined%20in%20Section%206.3.%0A%0AA%20registration%20whose%20%60expires_at%60%20value%20is%20%60none%60%20has%20no%20fixed%20expiration%20but%20remains%20subject%20to%20the%20liveness%20requirement.%0A%0A%23%23%23%23%204.5.3%20Updates%20and%20renewals%0A%0AAn%20ordinary%20%60update%60%20does%20not%20require%20the%20user%20to%20provide%20%60expires_at%60.%20The%20Mint%20reads%20the%20current%20accepted%20registration%20state%20and%20carries%20the%20current%20%60expires_at%60%20into%20the%20successor%20Name%20Note.%0A%0AAn%20ordinary%20%60update%60%20MUST%20NOT%20extend%2C%20shorten%2C%20restart%2C%20or%20remove%20the%20current%20registration%20period.%0A%0AAn%20%60update%60%20MAY%20request%20a%20registration%20extension.%20The%20user%20supplies%20the%20requested%20additional%20term%2C%20not%20an%20absolute%20expiration%20timestamp.%0A%0AFor%20a%20finite%20registration%3A%0A%0A%20%20%20%20new_expires_at%20%3D%20current_expires_at%20%2B%20requested_term%0A%0AIf%20no%20extension%20is%20requested%3A%0A%0A%20%20%20%20new_expires_at%20%3D%20current_expires_at%0A%0AIf%20the%20current%20%60expires_at%60%20is%20%60none%60%2C%20an%20ordinary%20term%20extension%20does%20not%20change%20it.%0A%0AThe%20extension%20is%20added%20to%20the%20existing%20%60expires_at%60%2C%20rather%20than%20to%20the%20current%20time.%0A%0AOnce%20the%20expiration%20condition%20has%20been%20reached%2C%20the%20Mint%20MUST%20NOT%20accept%20a%20new%20renewal%20request%20and%20MUST%20create%20the%20required%20%60release%60%20Name%20Note.%0A%0AAn%20update%20or%20renewal%20affects%20the%20registration%20only%20if%20its%20Name%20Note%20is%20accepted%20in%20a%20block%20preceding%20any%20%60release%60%20Name%20Note%20that%20ends%20the%20registration.%0A%0AIf%20an%20%60update%60%20and%20%60release%60%20for%20the%20same%20current%20registration%20are%20accepted%20in%20the%20same%20block%20and%20both%20reference%20the%20same%20predecessor%2C%20the%20%60release%60%20takes%20precedence%20regardless%20of%20the%20update's%20purpose%20or%20resulting%20%60expires_at%60.%0A%0AIf%20the%20%60release%60%20is%20accepted%20in%20an%20earlier%20block%2C%20the%20registration%20has%20ended%20and%20a%20later%20%60update%60%20does%20not%20affect%20registry%20state.%0A%0AAn%20%60update%60%20MAY%20retain%20the%20currently%20bound%20Unified%20Address.%20Such%20an%20update%20may%20be%20used%20for%20renewal%2C%20liveness%20confirmation%2C%20or%20both.%0A%0A%23%23%23%23%204.5.4%20Liveness%0A%0AThe%20Mint%20is%20responsible%20for%20tracking%20and%20enforcing%20liveness.%0A%0AThe%20current%20ZNS%20deployment%20MUST%20fix%20the%20liveness%20interval%20%24L%24%20in%20seconds.%20~~The%20interval%20is%20selected%20to%20correspond%20approximately%20to%20twelve%20months.%0A%0AFor%20a%20registration%20whose%20most%20recent%20liveness%20time%20is%20%24%5Ctau%24%2C%20the%20liveness%20deadline%20is%3A%0A%0A%20%20%20%20liveness_deadline%20%3D%20%CF%84%20%2B%20L%0A%20%20%20%20%0AThe%20initial%20liveness%20interval%20begins%20when%20the%20%60claim%60%20Name%20Note%20is%20accepted%20on%20the%20canonical%20Zcash%20chain.%20A%20successfully%20authorized%20%60update%60%20resets%20the%20liveness%20interval%20when%20the%20resulting%20Name%20Note%20is%20accepted%20on%20the%20canonical%20chain%2C%20including%20an%20update%20that%20retains%20the%20currently%20bound%20Unified%20Address.%0A%0AThe%20liveness%20time%20of%20a%20%60claim%60%20or%20%60update%60%20is%20derived%20from%20the%20canonical-chain%20MTP%20associated%20with%20the%20block%20containing%20that%20accepted%20Name%20Note.%0A%0AThe%20Mint%20records%20the%20most%20recent%20successful%20liveness%20event%20in%20protected%20persistent%20state%20and%20derives%20the%20next%20liveness%20deadline%20using%20canonical-chain%20MTP.%20If%20a%20chain%20reorganization%20removes%20or%20changes%20a%20%60claim%60%20or%20%60update%60%20used%20to%20establish%20the%20current%20liveness%20time%2C%20the%20Mint%20MUST%20reconcile%20its%20protected%20lifecycle%20state%20with%20the%20replacement%20canonical%20chain%20before%20enforcing%20the%20resulting%20liveness%20deadline.%0A%0ARequesting%20an%20OTP%20does%20not%20satisfy%20liveness.%20A%20failed%2C%20expired%2C%20or%20incomplete%20OTP%20exchange%20does%20not%20satisfy%20liveness.%20A%20liveness%20interval%20resets%20only%20when%20the%20resulting%20%60update%60%20Name%20Note%20is%20accepted%20on%20the%20canonical%20Zcash%20chain.%0A%0AIf%20the%20required%20liveness%20interval%20passes%20without%20a%20successful%20liveness%20event%2C%20the%20Mint%20MUST%20create%20a%20%60release%60%20Name%20Note.%0A%0AFor%20a%20fixed-term%20registration%2C%20the%20Mint%20MUST%20create%20a%20release%20when%20either%20the%20committed%20%60expires_at%60%20is%20reached%20or%20the%20liveness%20requirement%20fails%2C%20whichever%20occurs%20first.%0A%0AAn%20%60update%60%20affects%20the%20registration%20only%20if%20it%20is%20accepted%20in%20a%20block%20preceding%20the%20required%20%60release%60.%20If%20the%20update%20and%20release%20are%20accepted%20in%20the%20same%20block%20and%20reference%20the%20same%20current%20predecessor%2C%20the%20release%20takes%20precedence.%0A%0ALiveness%20enforcement%20is%20performed%20by%20the%20attested%20Mint%20and%20is%20not%20part%20of%20the%20Resolver's%20required%20state-derivation%20procedure.%20%0A%0A%23%23%23%23%204.5.5%20Release%20conditions%0AThe%20Mint%20MUST%20create%20a%20%60release%60%20Name%20Note%20when%20any%20of%20the%20following%20occurs%3A%0A%0A1.%20the%20controller%20successfully%20completes%20the%20required%20authorization%20procedure%20for%20an%20explicit%20%60release%60%3B%0A2.%20canonical-chain%20MTP%20reaches%20the%20committed%20%60expires_at%60%3B%20or%0A3.%20the%20current%20liveness%20deadline%20is%20reached%20without%20an%20accepted%20%60update%60%20Name%20Note%20having%20reset%20the%20liveness%20interval.%0A%0AThe%20first%20condition%20is%20a%20controller-requested%20release%20and%20requires%20the%20OTP%20authorization%20procedure%20defined%20in%20Section%205.%20The%20second%20and%20third%20conditions%20are%20lifecycle%20releases%20created%20by%20the%20Mint%20and%20do%20not%20require%20user%20authorization.%0A%0AReaching%20an%20expiration%20or%20liveness%20deadline%20does%20not%20itself%20modify%20registry%20state.%20Registry%20state%20changes%20only%20when%20the%20resulting%20%60release%60%20Name%20Note%20is%20accepted%20on%20the%20canonical%20Zcash%20chain.%0A%0AAn%20%60update%60%20affects%20the%20current%20registration%20only%20if%20it%20is%20accepted%20in%20a%20block%20preceding%20the%20%60release%60.%20If%20an%20%60update%60%20and%20%60release%60%20referencing%20the%20same%20current%20predecessor%20are%20accepted%20in%20the%20same%20block%2C%20the%20%60release%60%20takes%20precedence.%0A%0AAfter%20a%20%60release%60%2C%20a%20subsequent%20%60claim%60%20begins%20a%20new%20registration%20and%20uses%20the%20zero%20predecessor%20defined%20in%20Section%203.%0A%0A%0A%23%23%23%204.6%20On-chain%20completeness%0A%0AA%20Resolver%20must%20be%20able%20to%20reconstruct%20registry%20state%20from%20the%20on-chain%20Name%20Note%20history%20without%20relying%20on%20the%20Mint%20as%20a%20data%20source.%20Every%20accepted%20transition%20must%20therefore%20be%20fully%20represented%20in%20its%20Name%20Note.%20The%20Mint%20must%20not%20omit%20a%20transition%20field%20or%20replace%20it%20with%20an%20off-chain%20pointer.%0A%0AFor%20a%20%60claim%60%20or%20%60update%60%2C%20the%20resulting%20%60expires_at%60%20is%20part%20of%20the%20transition%20and%20MUST%20be%20present%20in%20the%20Name%20Note.%20The%20requested%20registration%20term%2C%20requested%20extension%2C%20and%20MTP%20values%20used%20by%20the%20Mint%20to%20apply%20lifecycle%20policy%20are%20policy%20inputs%20and%20need%20not%20be%20repeated%20in%20the%20Name%20Note.%0A%0AFor%20a%20%60release%60%2C%20the%20Name%20Note%20records%20the%20Unified%20Address%20of%20the%20binding%20being%20released.%0A%0AThe%20protocol's%20validity%20limits%20on%20names%2C%20Unified%20Addresses%2C%20and%20other%20encoded%20fields%20MUST%20ensure%20that%20every%20valid%20ZNS%20transition%20fits%20within%20a%20single%20512-byte%20Name%20Note%20memo.%0A%0A%0A%23%23%205%20User%20Authorization%0A%0AZcash%20shielded%20addresses%20do%20not%20provide%20a%20standard%20message-signing%20mechanism%20for%20authorizing%20changes%20to%20an%20existing%20name.%20ZNS%20therefore%20uses%20an%20in-band%20one-time%20passcode%20(OTP)%20delivered%20through%20Zcash's%20native%20shielded%20encryption.%0A%0AFor%20an%20%60update%60%20or%20controller-requested%20%60release%60%2C%20the%20Mint%20sends%20a%20fresh%20random%20challenge%20to%20the%20Unified%20Address%20currently%20bound%20to%20the%20name.%20The%20OTP%20is%20bound%20to%20the%20requested%20transition%2C%20expires%20after%20a%20fixed%20time%20interval%20measured%20using%20canonical-chain%20MTP%2C%20and%20is%20consumed%20on%20successful%20use.%20The%20controller%20returns%20the%20OTP%20to%20the%20Mint%20by%20sending%20it%20in%20a%20shielded%20memo%20to%20the%20Mint's%20designated%20admin%2Ftreasury%20wallet.%20Receipt%20of%20the%20correct%20OTP%20within%20that%20window%20demonstrates%20both%20the%20ability%20to%20decrypt%20shielded%20messages%20sent%20to%20the%20selected%20receiver%20and%20temporal%20liveness.%0A%0AA%20lifecycle%20%60release%60%20created%20by%20the%20Mint%20to%20enforce%20expiration%20or%20liveness%20does%20not%20require%20an%20OTP.%0A%0A%0AA%20%60claim%60%20has%20no%20existing%20controller%20and%20therefore%20requires%20no%20OTP.%0A%0A!%5BUser%20authorization%20flow%5D(zns-protocol-white-paper-main-draft-assets%2Fuser-authorization-flow.png)%0A%0A%0A%23%23%23%205.1%20Authorization%20target%0A%0A~~For%20an%20update%20or%20release%2C%20the%20Mint%20sends%20the%20OTP%20to%20the%20Ironwood%20receiver%20contained%20in%20the%20Unified%20Address%20currently%20bound%20to%20the%20name.~~%20For%20an%20%60update%60%20or%20controller-requested%20%60release%60%2C%20the%20Mint%20sends%20the%20OTP%20to%20the%20Ironwood%20receiver%20contained%20in%20the%20Unified%20Address%20currently%20bound%20to%20the%20name.%20The%20Mint%20MUST%20reject%20authorization%20if%20that%20Unified%20Address%20does%20not%20contain%20an%20Ironwood%20receiver.%20Successful%20authorization%20establishes%20access%20to%20that%20receiver%20only%2C%20not%20to%20any%20other%20receiver%20contained%20in%20the%20Unified%20Address.%0A%0AFor%20an%20update%2C%20authorization%20does%20not%20verify%20control%20of%20the%20proposed%20new%20Unified%20Address.%20A%20valid%20but%20unintended%20or%20substituted%20Unified%20Address%20can%20therefore%20become%20the%20new%20binding.%0A%0AAn%20update%20MAY%20specify%20the%20currently%20bound%20Unified%20Address%20as%20the%20target%20address%20when%20performed%20for%20renewal%2C%20liveness%20confirmation%2C%20or%20both.%0A%0A%23%23%23%205.2%20OTP%20relay%20memo%0A%0AThe%20Mint%20delivers%20the%20OTP%20in%20an%20Ironwood%20shielded%20memo.%20The%20non-padding%20bytes%20are%3A%0A%0A%60%60%60text%0AZNS%3Aotp%3A%3Cname%3E%3A%3Cverb%3E%3A%3Cua%3E%3A%3Cotp%3E%0A%60%60%60%0A%0AThe%20%60%3Cverb%3E%60%20field%20is%20%60update%60%20or%20%60release%60.%20The%20%60%3Cua%3E%60%20field%20is%20the%20target%20Unified%20Address%20from%20the%20request.%20The%20%60%3Cotp%3E%60%20field%20is%20exactly%20six%20ASCII%20decimal%20digits%2C%20including%20leading%20zeroes.%0A%0AThe%20memo%20is%20exactly%20512%20bytes%20and%20zero-padded.%20The%20%60otp%60%20message%20type%20distinguishes%20it%20from%20a%20name%20request%2C%20and%20a%20request%20parser%20MUST%20reject%20it%20as%20such.%0A%0AOTP%20relay%20memos%20are%20sent%20from%20a%20separate%20Mint%20account%20whose%20viewing%20key%20is%20not%20public.%0A%0A%23%23%23%205.3%20OTP%20validity%0A%0AThe%20Mint%20generates%20each%20OTP%20uniformly%20from%20%60000000%60%20through%20%60999999%60%20using%20a%20cryptographically%20secure%20random%20source%20inside%20the%20attested%20environment%20%5B7%5D.%0A%0AFor%20an%20%60update%60%2C%20the%20Mint%20computes%20the%20resulting%20%60expires_at%60%20before%20issuing%20the%20OTP%20and%20binds%20the%20OTP%20to%20the%20exact%20%60(name%2C%20action%2C%20ua%2C%20expires_at)%60%20tuple%20in%20its%20protected%20state.%0A%0AFor%20an%20ordinary%20update%2C%20%60expires_at%60%20is%20the%20current%20accepted%20expiration%20value%20carried%20forward%20unchanged.%20For%20a%20renewal%2C%20%60expires_at%60%20is%20the%20value%20obtained%20by%20adding%20the%20requested%20additional%20term%20to%20the%20current%20accepted%20expiration.%0A%0AThe%20user%20is%20not%20required%20to%20supply%20the%20resulting%20absolute%20%60expires_at%60%20as%20a%20request%20field.%20The%20Mint%20MUST%20accept%20the%20OTP%20only%20for%20the%20same%20pending%20update%20and%20MUST%20reject%20it%20if%20the%20resulting%20%60(name%2C%20action%2C%20ua%2C%20expires_at)%60%20would%20differ%20from%20the%20tuple%20to%20which%20the%20OTP%20was%20issued.%0A%0AFor%20a%20controller-requested%20%60release%60%2C%20the%20OTP%20remains%20bound%20to%20the%20applicable%20%60(name%2C%20action%2C%20ua)%60%20values.%20Lifecycle%20releases%20created%20by%20the%20Mint%20to%20enforce%20expiration%20or%20liveness%20do%20not%20use%20OTP%20authorization.%0A%0AThe%20current%20ZNS%20deployment%20MUST%20fix%20the%20OTP%20validity%20duration%20%24D_%7BOTP%7D%24%20in%20seconds%20and%20the%20maximum%20number%20of%20verification%20attempts.%20%0A%0AIf%20an%20OTP%20is%20issued%20when%20canonical-chain%20MTP%20is%20%24%5Ctau%24%2C%20define%3A%0A%0A%20%20%20%20otp_expires_at%20%3D%20%CF%84%20%2B%20D_OTP%0A%0AThe%20Mint%20MUST%20reject%20the%20OTP%20when%20canonical-chain%20MTP%20is%20greater%20than%20or%20equal%20to%20%60otp_expires_at%60.%0A%0AThe%20Mint%20MUST%20also%20reject%20an%20OTP%20presented%20for%20a%20different%20bound%20transition%2C%20an%20OTP%20that%20exceeds%20the%20permitted%20number%20of%20attempts%2C%20or%20an%20OTP%20that%20has%20already%20been%20successfully%20used.%20A%20successfully%20used%20OTP%20is%20consumed%20and%20MUST%20NOT%20be%20accepted%20again%20for%20the%20same%20request.%0A%0AOTP%20expiration%20is%20independent%20of%20registration%20expiration%20and%20the%20liveness%20deadline.%0A%0A%0A~~Under%20the%20TEE%20assumptions%2C%20attestation%20establishes%20that%20the%20Mint%20executed%20the%20approved%20authorization%20procedure.~~%0A%0A%23%23%23%205.4%20Public%20verification%20boundary%0A%0AThe%20OTP%20exchange%20does%20not%20produce%20public%20evidence%20of%20user%20authorization.%20A%20Resolver%20can%20verify%20the%20resulting%20Name%20Note%2C%20including%20the%20%60expires_at%60%20value%20committed%20by%20an%20%60update%60%2C%20as%20well%20as%20Mint%20authorization%20and%20attestation%2C%20but%20it%20cannot%20reconstruct%20the%20OTP%20exchange%20or%20independently%20verify%20that%20the%20OTP%20was%20bound%20to%20that%20transition%20from%20the%20on-chain%20Name%20Note%20history.%0A%0AUnder%20the%20TEE%20assumptions%2C%20attestation%20establishes%20that%20the%20Mint%20executed%20the%20approved%20authorization%20procedure.%0A%0A%23%23%206%20The%20Resolver%0A%0AThe%20Zcash%20chain%20records%20Name%20Notes%20in%20canonical%20order%2C%20but%20it%20does%20not%20determine%20which%20transitions%20belong%20in%20the%20registry.%20A%20Resolver%20verifies%20each%20Name%20Note%20and%20applies%20accepted%20transitions%20to%20derive%20registry%20state.%0A%0AAnyone%20can%20independently%20run%20a%20Resolver.%20Resolvers%20reading%20the%20same%20canonical%20Zcash%20chain%20under%20the%20current%20protocol%20rules%20must%20derive%20the%20same%20registry%20state.%0A%0A%23%23%23%206.1%20Resolver%20responsibilities%0A%0AA%20Resolver%20must%3A%0A%0A1.%20scan%20the%20canonical%20Zcash%20chain%20using%20the%20Mint's%20published%20full%20viewing%20key%20to%20identify%20and%20decrypt%20Ironwood%20outputs%2C%20obtaining%20their%20memos%20and%20note%20components%3B%0A2.%20parse%20the%20decrypted%20outputs%20to%20identify%20Name%20Note%20candidates%3B%0A3.%20verify%20each%20candidate's%20note%20commitment%20using%20the%20ZNS-specific%20derivation%20of%20%24rcm%24%20and%20%24%5Cpsi%24%20defined%20in%20Section%203%3B%0A4.%20verify%20Mint%20authorization%20and%20attestation%20as%20specified%20in%20Section%204%3B%0A5.%20apply%20accepted%20transitions%20in%20canonical%20order%20to%20derive%20registry%20state%3B%20and%0A6.%20provide%20clients%20with%20the%20current%20and%20historical%20binding%20state%20of%20each%20name%2C%20including%20the%20%60expires_at%60%20value%20committed%20by%20the%20applicable%20Name%20Note.%0A%0A%0AIf%20a%20chain%20reorganization%20changes%20the%20canonical%20Zcash%20history%2C%20the%20Resolver%20MUST%20roll%20back%20any%20state%20derived%20from%20removed%20blocks%20and%20replay%20the%20replacement%20chain%20from%20the%20common%20ancestor.%0A%0A%0A%23%23%23%206.2%20Candidate%20verification%0A%0ABefore%20state%20derivation%2C%20the%20Resolver%20verifies%20two%20properties%20of%20each%20Name%20Note%20candidate%3A%0A%0A**1.%20Name%20Note%20verification.**%20The%20Resolver%20parses%20the%20encoded%20transition%20and%20reconstructs%20the%20note%20commitment%20as%20specified%20in%20Section%203.%20The%20candidate%20passes%20Name%20Note%20verification%20only%20if%20the%20reconstructed%20note%20commitment%20matches%20the%20%60cmx%60%20recorded%20on-chain.%0A%0A**2.%20Mint%20authorization.**%20The%20Resolver%20uses%20the%20Mint%E2%80%99s%20published%20viewing%20key%20to%20identify%20Name%20Notes%20created%20by%20the%20Mint%20and%20verifies%20the%20Mint%E2%80%99s%20attestation%20as%20specified%20in%20Section%204.%0A%0AUser%20authorization%20is%20not%20independently%20reconstructed%20by%20the%20Resolver.%20As%20described%20in%20Section%205%2C%20the%20OTP%20exchange%20does%20not%20produce%20public%20evidence%20of%20an%20individual%20authorization%20event.%20Under%20the%20TEE%20assumptions%2C%20the%20Resolver%20relies%20on%20Mint%20attestation%20to%20establish%20that%20the%20approved%20authorization%20procedure%20was%20executed.%0A%0A%23%23%23%206.3%20State%20derivation%0A%0A%0AThe%20Resolver%20processes%20verified%20Name%20Note%20candidates%20in%20ascending%20canonical%20block%20order.%20Within%20a%20block%2C%20candidates%20are%20ordinarily%20processed%20according%20to%20transaction%20and%20action%20order%2C%20subject%20to%20the%20same-block%20release%20precedence%20rule%20below.%0A%0AFor%20each%20name%2C%20the%20%60prev_rcm%60%20field%20links%20a%20transition%20to%20the%20preceding%20Name%20Note%20within%20the%20current%20registration.%20A%20%60claim%60%2C%20including%20one%20following%20a%20%60release%60%2C%20uses%20the%20zero%20predecessor%20defined%20in%20Section%203.%20An%20%60update%60%20or%20%60release%60%20is%20accepted%20only%20if%20its%20%60prev_rcm%60%20matches%20the%20%60rcm%60%20of%20the%20current%20accepted%20Name%20Note.%0A%0AIf%20the%20same%20block%20contains%20both%20one%20or%20more%20%60update%60%20candidates%20and%20one%20or%20more%20%60release%60%20candidates%20for%20the%20same%20name%20that%20reference%20the%20%60rcm%60%20of%20the%20same%20current%20accepted%20Name%20Note%2C%20the%20Resolver%20considers%20the%20%60release%60%20candidates%20before%20the%20competing%20%60update%60%20candidates%20regardless%20of%20their%20relative%20transaction%20order%20within%20that%20block.%0A%0AIf%20more%20than%20one%20competing%20%60release%60%20references%20that%20predecessor%2C%20the%20releases%20are%20considered%20according%20to%20transaction%20and%20action%20order.%20Once%20one%20release%20is%20accepted%2C%20the%20registration%20ends%20and%20the%20remaining%20competing%20transitions%20referencing%20the%20former%20predecessor%20do%20not%20affect%20registry%20state.%0A%0AAn%20%60update%60%20therefore%20affects%20the%20registration%20only%20if%20it%20is%20accepted%20in%20a%20block%20preceding%20the%20block%20containing%20a%20competing%20%60release%60.%20An%20update%20accepted%20in%20the%20same%20block%20as%20that%20release%20does%20not%20affect%20registry%20state.%0A%0AEach%20accepted%20transition%20updates%20the%20registry%20state%20for%20that%20name.%20A%20transition%20whose%20predecessor%20does%20not%20match%20the%20current%20accepted%20state%20does%20not%20affect%20the%20registry.%0A%0A%0A%23%23%207%20Trust%20Assumptions%0A%0AZNS%20relies%20on%20the%20following%20trust%20assumptions%3A%0A%0A%23%23%23%207.1%20Zcash%20consensus%0A%0AZNS%20assumes%20that%20Zcash%20consensus%20provides%20the%20canonical%20ordering%20and%20availability%20of%20Name%20Notes.%20Registry%20history%20can%20be%20reconstructed%20from%20that%20chain%20without%20relying%20on%20the%20Mint%20to%20preserve%20a%20separate%20database.%0A%0AZNS%20treats%20Median%20Time%20Past%20derived%20from%20the%20canonical%20Zcash%20chain%20as%20the%20authoritative%20time%20source%20for%20Mint-enforced%20protocol%20periods.%0A%0A%0A%23%23%23%207.2%20TEE%20security%0A%0AZNS%20assumes%20that%20the%20selected%20TEE%20correctly%20executes%20the%20approved%20Mint%20code%2C%20protects%20the%20Mint%20spending%20key%2C%20and%20provides%20trustworthy%20remote%20attestation.%20This%20includes%20enforcement%20of%20claim%20eligibility%2C%20authorization%2C%20lifecycle%2C%20and%20pricing%20rules%2C%20correct%20calculation%20of%20%60expires_at%60%2C%20and%20correct%20use%20of%20canonical-chain%20MTP%20for%20expiration%2C%20liveness%2C%20and%20OTP%20validity.%0A%0AA%20compromise%20of%20these%20properties%20could%20allow%20the%20Mint%20policy%20to%20be%20bypassed%20or%20unauthorized%20Name%20Notes%20to%20be%20created%2C%20but%20it%20would%20not%20allow%20previously%20confirmed%20Name%20Notes%20to%20be%20removed%20or%20rewritten%20outside%20Zcash%20consensus.%0A%0A%0A%23%23%23%207.3%20User%20viewing%20access%0A%0AZNS%20assumes%20that%20the%20current%20controller%20retains%20viewing%20access%20to%20the%20Ironwood%20receiver%20of%20the%20bound%20Unified%20Address.%20This%20access%20is%20required%20to%20complete%20%60update%60%20and%20%60release%60%20authorization%20and%20to%20satisfy%20the%20liveness%20requirement.%20ZNS%20does%20not%20require%20or%20verify%20spending%20authority%20over%20that%20receiver.%0A%0ALoss%20of%20viewing%20access%20prevents%20the%20controller%20from%20authorizing%20subsequent%20changes%20or%20satisfying%20the%20liveness%20requirement.%0A%0A%23%23%23%207.4%20Price%20data%0A%0AIf%20registration%20pricing%20depends%20on%20external%20market%20data%2C%20ZNS%20assumes%20that%20the%20price%20data%20supplied%20to%20the%20Mint%20is%20available%20and%20accurate%20enough%20to%20apply%20the%20pricing%20policy.%20Incorrect%20price%20data%20can%20affect%20registration%20prices%20but%20cannot%20alter%20previously%20recorded%20Name%20Notes.%0A%0A%23%23%23%207.5%20Protected-name%20access%0A%0ADuring%20a%20protection%20period%2C%20ZNS%20assumes%20that%20access%20codes%20are%20issued%20only%20to%20authorized%20claimants%20and%20remain%20unavailable%20to%20unauthorized%20parties.%20Disclosure%20or%20improper%20issuance%20of%20a%20valid%20access%20code%20can%20allow%20a%20protected%20name%20to%20be%20claimed%20before%20the%20protection%20period%20ends.%0A%0A%23%23%23%207.6%20Mint%20availability%0A%0AZNS%20assumes%20that%20the%20Mint%20remains%20available%20to%20evaluate%20requests%20and%20create%20required%20lifecycle%20%60release%60%20Name%20Notes.%20If%20the%20Mint%20becomes%20unavailable%2C%20existing%20registry%20state%20remains%20reconstructible%2C%20but%20new%20transitions%20cannot%20occur.%20An%20expiration%20or%20liveness%20deadline%20may%20be%20reached%20while%20the%20Mint%20is%20unavailable%2C%20but%20reaching%20the%20deadline%20does%20not%20itself%20change%20registry%20state.%20The%20registration%20remains%20in%20the%20derived%20registry%20until%20the%20required%20%60release%60%20Name%20Note%20is%20accepted%20on%20the%20canonical%20Zcash%20chain.%0A%0A%23%23%208%20Privacy%20Considerations%0A%0AZNS%20does%20not%20provide%20registration%20privacy%2C%20resolution-query%20privacy%2C%20or%20protection%20against%20a%20Resolver%20presenting%20a%20client%20with%20stale%20chain%20state.%0A%0AThe%20Name%20Note%20account%E2%80%99s%20published%20full%20viewing%20key%20allows%20anyone%20to%20read%20the%20ZNS%20registry%20history%2C%20including%20names%2C%20%60claim%60%2C%20%60update%60%2C%20and%20%60release%60%20transitions%2C%20associated%20Unified%20Addresses%2C%20committed%20%60expires_at%60%20values%20when%20present%2C%20and%20predecessor%20references.%20ZNS%20therefore%20does%20not%20hide%20name%20bindings%20or%20their%20history.%0A%0AInformation%20outside%20the%20Name%20Note%20history%20may%20also%20be%20observable.%20The%20Mint%20can%20observe%20requests%20and%20authorization%20exchanges.%20A%20remotely%20queried%20Resolver%20can%20observe%20the%20names%20requested%20by%20a%20client.%20Wallet%20providers%20and%20network%20observers%20may%20observe%20connection%20metadata%20such%20as%20IP%20addresses%20and%20request%20timing%2C%20depending%20on%20how%20the%20client%20accesses%20ZNS.%0A%0APublishing%20a%20Unified%20Address%20as%20a%20name%20binding%20does%20not%20expose%20the%20shielded%20payments%20sent%20to%20that%20address%20or%20create%20a%20public%20transaction%20history%20for%20those%20payments.%0A%0A%23%23%209%20ZNS%20Improvement%20Proposals%0A%0AProtocol%20changes%20are%20specified%20through%20ZNS%20Improvement%20Proposals%20(ZNSIPs).%20Each%20ZNSIP%20is%20identified%20as%20%60ZNSIP-NNN%3A%20%3CTitle%3E%60%20and%20stored%20as%20%60znsip-NNN.md%60%2C%20where%20%60NNN%60%20is%20assigned%20by%20the%20ZNSIP%20editors.%20A%20ZNSIP%20is%20submitted%20to%20the%20ZNSIP%20repository%20as%20a%20pull%20request.%20%0A%0AFollowing%20review%20and%20acceptance%20by%20the%20editors%2C%20the%20pull%20request%20is%20merged%20into%20the%20repository.%20Repository%20inclusion%20records%20the%20accepted%20proposal%20but%20does%20not%20constitute%20protocol%20activation.%0A%0AThe%20ZNSIP%20repository%20MUST%20maintain%20a%20public%20list%20of%20all%20active%20editors.%0A%0A%23%23%2010%20Glossary%0A%0ATerms%20defined%20in%20the%20body%20are%20collected%20here%20for%20reference.%20Their%20normative%20definitions%20remain%20in%20the%20referenced%20sections.%0A%0A%7C%20Term%20%7C%20Definition%20%7C%0A%7C---%7C---%7C%0A%7C%20**ZNS%20(Zcash%20Name%20Service)**%20%7C%20The%20name%20registry%20protocol%20specified%20by%20this%20document.%20%7C%0A%7C%20**Name%20Note**%20%7C%20An%20Ironwood%20output%20whose%20memo%20records%20a%20name%20transition%2C%20including%20its%20%60expires_at%60%20value%2C%20and%20whose%20ZNS-specific%20note-commitment%20inputs%20are%20derived%20from%20that%20transition%3B%20see%20Section%203.%20%7C%0A%7C%20**Transition**%20%7C%20A%20%60claim%60%2C%20%60update%60%2C%20or%20%60release%60%20recorded%20in%20a%20Name%20Note%20and%20represented%20by%20the%20tuple%20%24(%5Calpha%2C%20n%2C%20u%2C%20e%2C%20p)%24%3B%20see%20Section%203.%20%7C%0A%7C%20**Predecessor%20(%60prev_rcm%60)**%20%7C%20The%20%60rcm%60%20of%20the%20previously%20accepted%20Name%20Note%20for%20the%20same%20name%2C%20encoded%20as%2064%20lowercase%20hexadecimal%20characters.%20The%20initial%20%60claim%60%20uses%2064%20zeroes%3B%20see%20Section%203.%20%7C%0A%7C%20**Binding**%20%7C%20The%20association%20between%20a%20name%20and%20a%20Unified%20Address%20established%20by%20its%20accepted%20Name%20Note%20history.%20%7C%0A%7C%20**Registry%20state**%20%7C%20The%20set%20of%20name%20bindings%20derived%20from%20accepted%20Name%20Notes%20in%20canonical%20chain%20order%3B%20see%20Section%206.%20%7C%0A%7C%20**Name%20Note%20viewing%20key**%20%7C%20The%20published%20full%20viewing%20key%20for%20the%20Mint%20account%20used%20to%20create%20Name%20Notes.%20%7C%0A%7C%20**Name%20Note%20candidate**%20%7C%20A%20decrypted%20Ironwood%20output%20identified%20by%20the%20Resolver%20as%20a%20possible%20Name%20Note%20before%20all%20acceptance%20checks%20are%20complete%3B%20see%20Section%206.%20%7C%0A%7C%20**Mint**%20%7C%20The%20protocol's%20single%20registrar.%20It%20evaluates%20name%20requests%20under%20the%20naming%20policy%20and%20creates%20Name%20Notes%20for%20accepted%20requests%3B%20see%20Section%204.%20%7C%0A%7C%20**Mint%20authorization**%20%7C%20Authorization%20provided%20by%20the%20recognized%20Mint%20spending%20key%20and%20accepted%20subject%20to%20the%20attestation%20requirements%20in%20Section%204.%20%7C%0A%7C%20**Resolver**%20%7C%20A%20client%20that%20scans%20the%20canonical%20Zcash%20chain%20using%20the%20Name%20Note%20viewing%20key%2C%20verifies%20Name%20Note%20candidates%2C%20derives%20registry%20state%20according%20to%20Section%206%2C%20and%20provides%20current%20and%20historical%20binding%20state%2C%20including%20committed%20expiration%20values.%20%7C%0A%7C%20**User%20authorization**%20%7C%20The%20OTP%20procedure%20used%20to%20authorize%20an%20%60update%60%20or%20%60release%60.%20For%20an%20%60update%60%2C%20the%20OTP%20is%20bound%20to%20the%20resulting%20%60(name%2C%20action%2C%20ua%2C%20expires_at)%60%20values%3B%20see%20Section%205.%20%7C%0A%7C%20**One-time%20passcode%20(OTP)**%20%7C%20A%20six-digit%20decimal%20passcode%20sent%20by%20the%20Mint%20to%20the%20Ironwood%20receiver%20of%20the%20Unified%20Address%20currently%20bound%20to%20a%20name%20and%20returned%20to%20authorize%20an%20%60update%60%20or%20%60release%60%3B%20see%20Section%205.%20%7C%0A%7C%20**OTP%20relay%20memo**%20%7C%20An%20Ironwood%20shielded%20memo%20of%20the%20form%20%60ZNS%3Aotp%3A%3Cname%3E%3A%3Cverb%3E%3A%3Cua%3E%3A%3Cotp%3E%60%20used%20to%20deliver%20an%20OTP%3B%20see%20Section%205.%20%7C%0A%7C%20**Expiration%20(%60expires_at%60)**%20%7C%20The%20absolute%20Unix%20timestamp%20in%20whole%20seconds%20committed%20by%20a%20%60claim%60%20or%20%60update%60%20Name%20Note%2C%20or%20the%20exact%20value%20%60none%60%20for%20a%20registration%20without%20fixed%20expiration.%20%7C%0A%7C%20**Registration%20term**%20%7C%20A%20duration%20requested%20for%20an%20initial%20fixed-term%20registration%20or%20renewal.%20The%20user%20supplies%20a%20term%3B%20the%20Mint%20computes%20the%20resulting%20absolute%20%60expires_at%60.%20%7C%0A%7C%20**Median%20Time%20Past%20(MTP)**%20%7C%20The%20chain-derived%20time%20value%20obtained%20from%20the%20canonical%20Zcash%20chain%20and%20used%20by%20the%20Mint%20for%20protocol-defined%20time%20checks.%20%7C%0A%7C%20**Liveness%20time**%20%7C%20The%20canonical-chain%20MTP%20associated%20with%20the%20block%20containing%20the%20accepted%20%60claim%60%20or%20most%20recent%20accepted%20%60update%60%20for%20a%20registration.%20%7C%0A%7C%20**Liveness%20deadline**%20%7C%20The%20current%20liveness%20time%20plus%20the%20protocol-defined%20liveness%20interval.%20Reaching%20the%20deadline%20requires%20the%20Mint%20to%20create%20a%20%60release%60%20Name%20Note.%20%7C%0A%7C%20**ZNSIP**%20%7C%20A%20ZNS%20Improvement%20Proposal%20specifying%20a%20proposed%20protocol%20change%3B%20see%20Section%209.%20%7C%0A%0A%0AExternal%20terms%20inherited%20from%20the%20Zcash%20protocol%20specification%20%5B1%5D%20or%20its%20ZIPs%20are%20not%20redefined%20here%3A%20Ironwood%20action%2C%20Ironwood%20memo%2C%20note%20commitment%20(%60cmx%60)%2C%20Unified%20Address%2C%20and%20incoming%20viewing%20key%20retain%20the%20meaning%20fixed%20by%20their%20normative%20sources%20%5B3%2C%204%2C%201%5D.%0A%0A%0A%23%23%20References%0A%0A1.%20Electric%20Coin%20Company%20and%20Zcash%20Foundation.%20%5BZcash%20Protocol%20Specification%5D(https%3A%2F%2Fzips.z.cash%2Fprotocol%2Fprotocol.pdf).%0A2.%20Zcash%20Improvement%20Proposal%20212.%20%5BAllow%20Recipient%20to%20Derive%20Ephemeral%20Secret%20from%20Note%20Plaintext%5D(https%3A%2F%2Fzips.z.cash%2Fzip-0212).%0A3.%20Zcash%20Improvement%20Proposal%20224.%20%5BIronwood%20Shielded%20Protocol%5D(https%3A%2F%2Fzips.z.cash%2Fzip-0224).%0A4.%20Zcash%20Improvement%20Proposal%20316.%20%5BUnified%20Addresses%20and%20Unified%20Viewing%20Keys%5D(https%3A%2F%2Fzips.z.cash%2Fzip-0316).%0A5.%20S.%20Bradner%20and%20J.%20Leiba.%20%5BKey%20words%20for%20use%20in%20RFCs%20to%20Indicate%20Requirement%20Levels%5D(https%3A%2F%2Fwww.rfc-editor.org%2Finfo%2Fbcp14).%20BCP%2014%2C%20RFC%202119%20and%20RFC%208174.%0A6.%20Zcash%20Improvement%20Proposal%200.%20%5BZIP%20Process%5D(https%3A%2F%2Fzips.z.cash%2Fzip-0000).%0A7.%20zcashme.%20%5Bzns-mint%20reference%20implementation%5D(https%3A%2F%2Fgithub.com%2Fzcashme%2Fzns-mint).%0A","viewMode":"publish","unreadState":[],"isOwner":false,"isTeamMember":false,"isSignIn":false,"isLiked":false,"isBookmarked":false,"publishType":"view","commentCount":0,"isNotesRecommendationsEnabled":true,"lastChangeUserInfo":{"name":"Zechariah","path":"zec","avatarUrl":"https%3A%2F%2Fuploads-public.hackmd.io%2Fupload_22608bc420438caefb6f792826091589.png"}}`);
  window.owner = "86460926-f9ba-4e30-8f7f-a321d4e9510f";
  (function () {
    const decodeStringProps = (props) => {
      for (const key in props) {
        if (typeof props[key] === 'string') {
          props[key] = decodeURIComponent(props[key])
        } else if (typeof props[key] === 'object') {
          decodeStringProps(props[key])
        }
      }
    }
    decodeStringProps(window.publishProps)
  })()



    

    



    
    
[ZNS Audit Plan - Aug/Sept](https://hackmd.io/@zec/zns-audit-plan)
[Additions to the ZNS Protocol Whitepaper](/l_3XPiO5ReOA4s9o31YdDg)

# Zcash Name Service


## ~~A Deterministic Name Registry over the Ironwood Transaction Log~~ A Deterministic, Attested Name Registry on Zcash

```Note to author about title (do not include in paper):
Deterministic captures Resolver state derivation.
Attested captures the Mint&#39;s TEE-based authorization and policy enforcement.
Name Registry states exactly what the protocol is.
on Zcash is broader and more durable than tying the title to “the Ironwood transaction log.”
Ironwood can then be introduced precisely in the abstract and architecture sections.
```
**craftsoldier**  
[github.com/craftsoldier](https://github.com/craftsoldier) · [julian@zcash.me](mailto:julian@zcash.me)

**Zechariah**  
[github.com/ZcashUsersGroup](https://github.com/ZcashUsersGroup) · [james@zcash.me](mailto:james@zcash.me)

*Protocol draft — August 24, 2026*

| Field | Value |
|---|---|
| Status | Draft |
| Category | Standards Track |
| Created | August 24, 2026 |
| License | MIT |
| Discussion | [github.com/craftsoldier/zns-whitepaper](https://github.com/craftsoldier/zns-whitepaper) |

## Abstract

Zcash payments use encoded addresses, but Zcash consensus does not assign human-readable names to them. Existing on-chain naming systems cannot be ported to Zcash: transparent registries such as Namecoin publish the namespace in the clear, leaking the address graph Zcash exists to hide; contract-based registries such as ENS require general-purpose on-chain state that Zcash consensus does not provide. The Zcash Name Service (ZNS) maps each Zcash name to a Unified Address over the ordinary Zcash transaction log: each binding is recorded in the memo of an Ironwood action, decryptable with the Name Note account’s published full viewing key, and anchored by an Ironwood note commitment derived from the same tuple. Zcash consensus supplies canonical order and finality; a deterministic reducer derives the registry; the bound Unified Address inherits Ironwood shielding. Authorization is delivered by an attested Mint; a future off-chain zero-knowledge name circuit would replace that assumption with a proof.

**Status.** This document is a work in progress. Sections explicitly marked Open or Provisional are not interoperability requirements. Sections marked Fixed state normative requirements backed by the cited assumptions. An implementation cannot infer a protocol rule from an unresolved item. The key words MUST, MUST NOT, SHOULD, and MAY are to be interpreted as described by BCP 14 only when they appear in uppercase [5].

## 1 Motivation

Zcash addresses are long encoded strings. A naming system maps these strings to human-readable labels, but this requires enforcing rules about which names are claimed and who controls them. Zcash consensus tracks unspent coins. Lacking a virtual machine to run logic and a global state tree to store variables, it cannot evaluate a naming policy. To bypass this limitation, ZNS separates the execution of the naming policy from the permanent public record. A single party, the Mint, executes the policy off-chain. When a request passes, the Mint writes the resulting name binding into the 512-byte memo field of a shielded Zcash transaction. Zcash consensus seals the transaction into a block, locking the binding into a permanent, chronological order. A Resolver looking up a name downloads the Zcash block headers, uses a published viewing key to decrypt the Mint’s memos, and reads the bindings in the exact order consensus finalized them. The Mint issues names, but the accumulated work of the Zcash blockchain prevents it from altering or erasing previously recorded bindings.

## 2 Architecture

To guarantee the globally unique mapping of human-readable names to Zcash addresses, a naming system requires an agreed-upon history of requests to register, modify, or release names, a strict set of rules, and a resulting registry of name bindings. ZNS treats this registry as derived state by using Zcash exclusively for the history of these requests, executing rules off-chain, and binding their accepted results on-chain.

### 2.1 System Components

The protocol relies on three distinct components:

- **The Mint.** The authoritative off-chain program that evaluates the naming policy. It runs inside a Trusted Execution Environment (TEE), with its authority bound to approved protocol code through remote attestation.It uses its own Zcash node to read chain state independently.
- **The Name Note.** An Ironwood output used to record a name transition on-chain. 
- **The Resolver.** A permissionless client that reads the canonical sequence of Zcash transactions, verifies Name Notes and deterministically derives registry state.

### 2.2 Independence of Facts

The security of the derived state relies on six distinct properties. The Resolver verifies publicly reconstructible properties directly and relies on Mint attestation for policy checks that are not publicly reconstructible.

- **Zcash validity:** The transaction satisfies Zcash consensus.
- **Mint authorization:** The recognized Mint spending key authorized the transaction.
- **TEE attestation:** The recognized Mint identity executed the approved enclave code.
- **Name Note verification:** The transition tuple encoded in a Name Note matches its Ironwood note commitment.
- **User authorization:** The attested Mint enforces the authorization procedure defined in Section 5. 
- **State derivation**: Resolvers reading the canonical Zcash chain under identical protocol parameters derive the same registry state.

## 3 Name Notes


A Name Note is an Ironwood output whose memo records a name transition by encoding the type of name change, the name, the associated Unified Address when applicable, the expiration value, and a predecessor reference.

### 3.1 Memo encoding

The Name Note memo is a 512-byte field. A parser removes its maximal trailing sequence of zero bytes. The remaining bytes encode one transition in one of the following formats:


```text
ZNS:claim:&lt;name&gt;:&lt;ua&gt;:&lt;expires_at&gt;:&lt;prev_rcm&gt;
ZNS:update:&lt;name&gt;:&lt;ua&gt;:&lt;expires_at&gt;:&lt;prev_rcm&gt;
ZNS:release:&lt;name&gt;:&lt;ua&gt;:none:&lt;prev_rcm&gt;
```
    

The colon byte (`0x3a`) separates fields. The `&lt;expires_at&gt;` field is either the canonical ASCII decimal encoding of a Unix timestamp in whole seconds or the exact ASCII bytes `none`. The value `none` indicates that the registration has no fixed expiration. A `release` MUST encode `none` as its `expires_at` value and the Unified Address of the binding being released as its `ua` value.

The `prev_rcm` field is the 64-character lowercase hexadecimal encoding of the predecessor Name Note&#39;s `rcm` value. The first claim uses 64 zeroes.

### 3.2 Transition representation

To derive the ZNS-specific note-commitment inputs, $rcm_\sigma$ and $\psi_\sigma$, interpret the encoded transition as the tuple

$$
σ = (α, n, u, e, p)
$$


where:
* $\alpha$: The exact ASCII bytes `claim`, `update`, or `release`.
* $n$: The raw bytes of the name field.
* $u$: The raw bytes of the `ua` field. 
* $e$: The raw bytes of the `expires_at` field.
* $p$: The 32 raw bytes decoded from `prev_rcm`.


### 3.3 Commitment inputs

ZNS derives both commitment inputs from the same transition representation $\sigma$ using the same hash construction. Within the hash construction, the only difference is the ASCII derivation tag, `rcm` or `psi`. The resulting digests are then reduced into different Pallas fields.

To prevent ambiguous concatenation, define $LP(x)$ as the four-byte unsigned little-endian byte length of $x$, followed by $x$ itself. Define the protocol domain tag $T$ as the 12 ASCII bytes `ZcashName/v1`. Quotation marks are not part of $T$.

For derivation tag $t$, where $t$ is the exact ASCII byte string `rcm` or `psi`, define:


H_t(σ) =
BLAKE2b-512(
    LP(T) || LP(t) || LP(α) || LP(n) || LP(u) || LP(e) || p
).

Because $e$ is included in $\sigma$, both ZNS-specific commitment inputs cryptographically bind the `expires_at` value recorded in the Name Note.

The final $p$ is exactly 32 raw bytes and has no length prefix. Each $H_t$ invocation uses unkeyed BLAKE2b-512 with a 64-byte output and no additional personalization.

The two commitment inputs are then:

$$
rcm_\sigma = \operatorname{ToScalar}(H_{rcm}(\sigma)),
$$

$$
\psi_\sigma = \operatorname{ToBase}(H_{psi}(\sigma)).
$$

The value $rcm_\sigma$ is the Pallas scalar-field element used as the Ironwood note-commitment randomness.

The value $\psi_\sigma$ is the Pallas base-field element supplied to the Ironwood note commitment construction.

`ToScalar`, `ToBase`, and the field types are those defined for Ironwood by the Zcash Protocol Specification [1, 3]. Neither $rcm_\sigma$ nor $\psi_\sigma$ is a raw 64-byte BLAKE2b digest; each is the field element obtained by reducing the digest produced with its respective derivation tag. The canonical encoding of either field element is its 32-byte little-endian field representation. ZNS derives both field elements from $\sigma$, rather than from the rseed derivation used by ordinary ZIP-212 receiving [2, 1].

Changing the domain tag, a derivation tag, field order, length width, byte order, hash parameters, or reduction rule changes the protocol version and requires new test vectors.

### 3.4 Commitment verification

ZNS changes the derivation of $\psi$ and $rcm$ but does not otherwise change the standard note commitment construction. A verifier derives $\psi_\sigma$ and $rcm_\sigma$ from the encoded transition, combines them with the candidate&#39;s remaining note components using the standard construction [1, 3], and reconstructs the note commitment.

The Name Note passes commitment verification only if the reconstructed value equals the `cmx` recorded in the on-chain action.

This equality establishes only that the transition encoded in the memo is cryptographically bound to that output. It does not establish Mint authorization, user authorization, or the current registry state.

### 3.5 Commitment test vector

For a `claim` transition with `name=alice`, `expires_at=none`, and a 32-byte zero predecessor. Key material is derived from the all-zero 32-byte seed under unified account `m/32&#39;/133&#39;/1&#39;`, diversifier index 0, external scope, mainnet:

| Value | Canonical little-endian bytes rendered as hexadecimal |
|---|---|
| `ua` | `u1897y9pzw3zk6n9twtzu2z5kpkzw3hms2c54fpyv8lnr79m73tazljkk3veaxrtwncp66lf45p3f274xy2amqckx0sraje4v835yw8q0q` |
| `g_d` | `de4338f2ab9fd8300a3a1c20dd690ce27026c6001c295d7c641a067ce809b11e` |
| `pk_d` | `6df609f5710f3b5deecd4ee4b8f0173b44af6cf8918ac00269526031ba628996` |
| `psi_σ` | `9f8a61b860c737d4564f12c635d654b843bc7115d9dc6cf6f09e409c81b8d13e` |
| `rcm_σ` | `daa928be21d0ec13b5dbb0244699dbfeba546c71591d24d7824db78e4670c504` |

Set the value to zero and `rho` to 32 bytes of `0x33`. The resulting `cmx` is `cc320736a0c1df1e4ffcee2b64aa73a9e6d06bb218e155a6fef422e1ecb1f70c`. An implementation that produces another value is non-conforming.

The complete memo encoding of this transition is:

```text
ZNS:claim:alice:u1897y9pzw3zk6n9twtzu2z5kpkzw3hms2c54fpyv8lnr79m73tazljkk3veaxrtwncp66lf45p3f274xy2amqckx0sraje4v835yw8q0q:none:0000000000000000000000000000000000000000000000000000000000000000
```

## 4 The Mint

The Mint is the protocol&#39;s single registrar. A Name Note establishes that a transition is bound to an Ironwood output, but whether the transition is allowed depends on the current registry state and active naming policy. The Mint reads ordered requests on Zcash, derives that state, applies the policy, and for each accepted request spends a Mint-controlled note to create the successor Name Note.


### 4.1 Authority bound to policy

The Mint spending key provides the protocol&#39;s Mint authorization. The key can create a transition that appears to have been approved by the Mint without applying the naming policy. The key must therefore be usable only by the program that evaluates the policy.

ZNS runs the Mint inside a Trusted Execution Environment (TEE) and uses remote attestation to bind the Mint key to an approved enclave measurement. This shifts trust in policy execution and key custody from the Mint operator to the TEE attestation system and its hardware root of trust.

### 4.2 Attestation constraints

The Resolver recognizes Mint authorization only if the attestation establishes all of the following:

1. The enclave code measurement is approved by the current ZNS deployment.
2. The enclave controls the recognized Mint spending key.
3. The enclave runs the applicable ZNS protocol version.
4. The enclave targets the applicable Zcash network.
5. The enclave implements the required protected persistent-state mechanism for replay prevention.
6. The enclave obtains canonical-chain Median Time Past from the approved Zcash node interface and uses it as the authoritative time source for protocol-defined time checks.

The Resolver rejects the Mint authorization if any condition fails or if the TEE is not running in an approved production security configuration. 


Approved enclave measurements, attestation requirements, and the approved source of canonical-chain Median Time Past are deployment-specific. The exact attestation format and verification procedure depend on the selected TEE platform and remain Open until the deployment is fixed.

### 4.3 Claim eligibility

Some names may be designated as protected for a limited protection period to reduce impersonation, misleading claims of affiliation, and opportunistic registration of names associated with existing identities or projects.

A protected name is temporarily excluded from the standard public claim process. During the protection period, a claim must include a valid access code, which the Mint verifies according to the protected-name policy before accepting the claim.

Access-code verification is performed by the Mint under the attested protected-name policy and is not independently reconstructed by the Resolver.

When the protection period ends, an unclaimed protected name becomes eligible for the standard public claim process. Once a protected name is validly claimed, it is governed by the same transition and authorization rules as any other name.

### 4.4 Request evaluation

The Mint evaluates each request against the registry state it derives from the canonical Zcash chain. It must use its own Zcash node and its own replay of the namespace history rather than rely on a third-party state oracle. The Mint obtains canonical-chain Median Time Past from that node for protocol-defined time checks.

The Mint evaluates each request against the following requirements:

- **Namespace state.** The requested change must be permitted by the current state of the name.
- **Payment.** The request must satisfy the price and payment requirements defined by the active pricing policy.
- **Request validity.** The name, Unified Address when applicable, requested registration term or extension when applicable, and resulting encoded transition must satisfy the protocol&#39;s validity rules.
- **Lifecycle policy.** The request must satisfy the active registration, expiration, renewal, and liveness rules defined in Section 4.5.
- **User authorization.** An `update` or controller-requested `release` must complete the authorization procedure defined in Section 5. A lifecycle `release` created by the Mint to enforce expiration or liveness does not require user authorization.


If all applicable requirements are satisfied, the Mint accepts the request and creates the resulting Name Note.


### 4.5 Name lifecycle

ZNS uses canonical-chain Median Time Past (MTP) rather than block counts or local system time for protocol-defined lifecycle periods. MTP is derived from Zcash block timestamps and has one-second granularity. It is chain-derived time rather than exact wall-clock time.

#### 4.5.1 Initial claims

A `claim` request specifies the name, the Unified Address, and either a requested registration term or no fixed expiration. The user does not supply an absolute `expires_at` value.

For a fixed-term registration, the Mint computes `expires_at` by adding the requested registration term to the canonical-chain MTP of the block containing the accepted claim request.

The Mint determines `expires_at` from that block MTP and the requested registration term, subject to the active registration policy, and records the resulting value in the Name Note.

For a registration without a fixed expiration, `expires_at` is the exact ASCII value `none`.

Only the resulting `expires_at` value is included in the Name Note. The claim request&#39;s block MTP and requested registration term are policy inputs and are not repeated as transition fields.

#### 4.5.2 Expiration

For a fixed-term registration, the expiration condition is reached when:

    canonical_chain_mtp &gt;= expires_at

Reaching `expires_at` does not directly modify derived registry state. When the expiration condition is reached, the Mint MUST create a `release` Name Note.

The registration remains active in derived registry state until a `release` Name Note is accepted on the canonical Zcash chain, subject to the same-block precedence rule defined in Section 6.3.

A registration whose `expires_at` value is `none` has no fixed expiration but remains subject to the liveness requirement.

#### 4.5.3 Updates and renewals

An ordinary `update` does not require the user to provide `expires_at`. The Mint reads the current accepted registration state and carries the current `expires_at` into the successor Name Note.

An ordinary `update` MUST NOT extend, shorten, restart, or remove the current registration period.

An `update` MAY request a registration extension. The user supplies the requested additional term, not an absolute expiration timestamp.

For a finite registration:

    new_expires_at = current_expires_at + requested_term

If no extension is requested:

    new_expires_at = current_expires_at

If the current `expires_at` is `none`, an ordinary term extension does not change it.

The extension is added to the existing `expires_at`, rather than to the current time.

Once the expiration condition has been reached, the Mint MUST NOT accept a new renewal request and MUST create the required `release` Name Note.

An update or renewal affects the registration only if its Name Note is accepted in a block preceding any `release` Name Note that ends the registration.

If an `update` and `release` for the same current registration are accepted in the same block and both reference the same predecessor, the `release` takes precedence regardless of the update&#39;s purpose or resulting `expires_at`.

If the `release` is accepted in an earlier block, the registration has ended and a later `update` does not affect registry state.

An `update` MAY retain the currently bound Unified Address. Such an update may be used for renewal, liveness confirmation, or both.

#### 4.5.4 Liveness

The Mint is responsible for tracking and enforcing liveness.

The current ZNS deployment MUST fix the liveness interval $L$ in seconds. ~~The interval is selected to correspond approximately to twelve months.

For a registration whose most recent liveness time is $\tau$, the liveness deadline is:

    liveness_deadline = τ + L
    
The initial liveness interval begins when the `claim` Name Note is accepted on the canonical Zcash chain. A successfully authorized `update` resets the liveness interval when the resulting Name Note is accepted on the canonical chain, including an update that retains the currently bound Unified Address.

The liveness time of a `claim` or `update` is derived from the canonical-chain MTP associated with the block containing that accepted Name Note.

The Mint records the most recent successful liveness event in protected persistent state and derives the next liveness deadline using canonical-chain MTP. If a chain reorganization removes or changes a `claim` or `update` used to establish the current liveness time, the Mint MUST reconcile its protected lifecycle state with the replacement canonical chain before enforcing the resulting liveness deadline.

Requesting an OTP does not satisfy liveness. A failed, expired, or incomplete OTP exchange does not satisfy liveness. A liveness interval resets only when the resulting `update` Name Note is accepted on the canonical Zcash chain.

If the required liveness interval passes without a successful liveness event, the Mint MUST create a `release` Name Note.

For a fixed-term registration, the Mint MUST create a release when either the committed `expires_at` is reached or the liveness requirement fails, whichever occurs first.

An `update` affects the registration only if it is accepted in a block preceding the required `release`. If the update and release are accepted in the same block and reference the same current predecessor, the release takes precedence.

Liveness enforcement is performed by the attested Mint and is not part of the Resolver&#39;s required state-derivation procedure. 

#### 4.5.5 Release conditions
The Mint MUST create a `release` Name Note when any of the following occurs:

1. the controller successfully completes the required authorization procedure for an explicit `release`;
2. canonical-chain MTP reaches the committed `expires_at`; or
3. the current liveness deadline is reached without an accepted `update` Name Note having reset the liveness interval.

The first condition is a controller-requested release and requires the OTP authorization procedure defined in Section 5. The second and third conditions are lifecycle releases created by the Mint and do not require user authorization.

Reaching an expiration or liveness deadline does not itself modify registry state. Registry state changes only when the resulting `release` Name Note is accepted on the canonical Zcash chain.

An `update` affects the current registration only if it is accepted in a block preceding the `release`. If an `update` and `release` referencing the same current predecessor are accepted in the same block, the `release` takes precedence.

After a `release`, a subsequent `claim` begins a new registration and uses the zero predecessor defined in Section 3.


### 4.6 On-chain completeness

A Resolver must be able to reconstruct registry state from the on-chain Name Note history without relying on the Mint as a data source. Every accepted transition must therefore be fully represented in its Name Note. The Mint must not omit a transition field or replace it with an off-chain pointer.

For a `claim` or `update`, the resulting `expires_at` is part of the transition and MUST be present in the Name Note. The requested registration term, requested extension, and MTP values used by the Mint to apply lifecycle policy are policy inputs and need not be repeated in the Name Note.

For a `release`, the Name Note records the Unified Address of the binding being released.

The protocol&#39;s validity limits on names, Unified Addresses, and other encoded fields MUST ensure that every valid ZNS transition fits within a single 512-byte Name Note memo.


## 5 User Authorization

Zcash shielded addresses do not provide a standard message-signing mechanism for authorizing changes to an existing name. ZNS therefore uses an in-band one-time passcode (OTP) delivered through Zcash&#39;s native shielded encryption.

For an `update` or controller-requested `release`, the Mint sends a fresh random challenge to the Unified Address currently bound to the name. The OTP is bound to the requested transition, expires after a fixed time interval measured using canonical-chain MTP, and is consumed on successful use. The controller returns the OTP to the Mint by sending it in a shielded memo to the Mint&#39;s designated admin/treasury wallet. Receipt of the correct OTP within that window demonstrates both the ability to decrypt shielded messages sent to the selected receiver and temporal liveness.

A lifecycle `release` created by the Mint to enforce expiration or liveness does not require an OTP.


A `claim` has no existing controller and therefore requires no OTP.

![User authorization flow](zns-protocol-white-paper-main-draft-assets/user-authorization-flow.png)


### 5.1 Authorization target

~~For an update or release, the Mint sends the OTP to the Ironwood receiver contained in the Unified Address currently bound to the name.~~ For an `update` or controller-requested `release`, the Mint sends the OTP to the Ironwood receiver contained in the Unified Address currently bound to the name. The Mint MUST reject authorization if that Unified Address does not contain an Ironwood receiver. Successful authorization establishes access to that receiver only, not to any other receiver contained in the Unified Address.

For an update, authorization does not verify control of the proposed new Unified Address. A valid but unintended or substituted Unified Address can therefore become the new binding.

An update MAY specify the currently bound Unified Address as the target address when performed for renewal, liveness confirmation, or both.

### 5.2 OTP relay memo

The Mint delivers the OTP in an Ironwood shielded memo. The non-padding bytes are:

```text
ZNS:otp:&lt;name&gt;:&lt;verb&gt;:&lt;ua&gt;:&lt;otp&gt;
```

The `&lt;verb&gt;` field is `update` or `release`. The `&lt;ua&gt;` field is the target Unified Address from the request. The `&lt;otp&gt;` field is exactly six ASCII decimal digits, including leading zeroes.

The memo is exactly 512 bytes and zero-padded. The `otp` message type distinguishes it from a name request, and a request parser MUST reject it as such.

OTP relay memos are sent from a separate Mint account whose viewing key is not public.

### 5.3 OTP validity

The Mint generates each OTP uniformly from `000000` through `999999` using a cryptographically secure random source inside the attested environment [7].

For an `update`, the Mint computes the resulting `expires_at` before issuing the OTP and binds the OTP to the exact `(name, action, ua, expires_at)` tuple in its protected state.

For an ordinary update, `expires_at` is the current accepted expiration value carried forward unchanged. For a renewal, `expires_at` is the value obtained by adding the requested additional term to the current accepted expiration.

The user is not required to supply the resulting absolute `expires_at` as a request field. The Mint MUST accept the OTP only for the same pending update and MUST reject it if the resulting `(name, action, ua, expires_at)` would differ from the tuple to which the OTP was issued.

For a controller-requested `release`, the OTP remains bound to the applicable `(name, action, ua)` values. Lifecycle releases created by the Mint to enforce expiration or liveness do not use OTP authorization.

The current ZNS deployment MUST fix the OTP validity duration $D_{OTP}$ in seconds and the maximum number of verification attempts. 

If an OTP is issued when canonical-chain MTP is $\tau$, define:

    otp_expires_at = τ + D_OTP

The Mint MUST reject the OTP when canonical-chain MTP is greater than or equal to `otp_expires_at`.

The Mint MUST also reject an OTP presented for a different bound transition, an OTP that exceeds the permitted number of attempts, or an OTP that has already been successfully used. A successfully used OTP is consumed and MUST NOT be accepted again for the same request.

OTP expiration is independent of registration expiration and the liveness deadline.


~~Under the TEE assumptions, attestation establishes that the Mint executed the approved authorization procedure.~~

### 5.4 Public verification boundary

The OTP exchange does not produce public evidence of user authorization. A Resolver can verify the resulting Name Note, including the `expires_at` value committed by an `update`, as well as Mint authorization and attestation, but it cannot reconstruct the OTP exchange or independently verify that the OTP was bound to that transition from the on-chain Name Note history.

Under the TEE assumptions, attestation establishes that the Mint executed the approved authorization procedure.

## 6 The Resolver

The Zcash chain records Name Notes in canonical order, but it does not determine which transitions belong in the registry. A Resolver verifies each Name Note and applies accepted transitions to derive registry state.

Anyone can independently run a Resolver. Resolvers reading the same canonical Zcash chain under the current protocol rules must derive the same registry state.

### 6.1 Resolver responsibilities

A Resolver must:

1. scan the canonical Zcash chain using the Mint&#39;s published full viewing key to identify and decrypt Ironwood outputs, obtaining their memos and note components;
2. parse the decrypted outputs to identify Name Note candidates;
3. verify each candidate&#39;s note commitment using the ZNS-specific derivation of $rcm$ and $\psi$ defined in Section 3;
4. verify Mint authorization and attestation as specified in Section 4;
5. apply accepted transitions in canonical order to derive registry state; and
6. provide clients with the current and historical binding state of each name, including the `expires_at` value committed by the applicable Name Note.


If a chain reorganization changes the canonical Zcash history, the Resolver MUST roll back any state derived from removed blocks and replay the replacement chain from the common ancestor.


### 6.2 Candidate verification

Before state derivation, the Resolver verifies two properties of each Name Note candidate:

**1. Name Note verification.** The Resolver parses the encoded transition and reconstructs the note commitment as specified in Section 3. The candidate passes Name Note verification only if the reconstructed note commitment matches the `cmx` recorded on-chain.

**2. Mint authorization.** The Resolver uses the Mint’s published viewing key to identify Name Notes created by the Mint and verifies the Mint’s attestation as specified in Section 4.

User authorization is not independently reconstructed by the Resolver. As described in Section 5, the OTP exchange does not produce public evidence of an individual authorization event. Under the TEE assumptions, the Resolver relies on Mint attestation to establish that the approved authorization procedure was executed.

### 6.3 State derivation


The Resolver processes verified Name Note candidates in ascending canonical block order. Within a block, candidates are ordinarily processed according to transaction and action order, subject to the same-block release precedence rule below.

For each name, the `prev_rcm` field links a transition to the preceding Name Note within the current registration. A `claim`, including one following a `release`, uses the zero predecessor defined in Section 3. An `update` or `release` is accepted only if its `prev_rcm` matches the `rcm` of the current accepted Name Note.

If the same block contains both one or more `update` candidates and one or more `release` candidates for the same name that reference the `rcm` of the same current accepted Name Note, the Resolver considers the `release` candidates before the competing `update` candidates regardless of their relative transaction order within that block.

If more than one competing `release` references that predecessor, the releases are considered according to transaction and action order. Once one release is accepted, the registration ends and the remaining competing transitions referencing the former predecessor do not affect registry state.

An `update` therefore affects the registration only if it is accepted in a block preceding the block containing a competing `release`. An update accepted in the same block as that release does not affect registry state.

Each accepted transition updates the registry state for that name. A transition whose predecessor does not match the current accepted state does not affect the registry.


## 7 Trust Assumptions

ZNS relies on the following trust assumptions:

### 7.1 Zcash consensus

ZNS assumes that Zcash consensus provides the canonical ordering and availability of Name Notes. Registry history can be reconstructed from that chain without relying on the Mint to preserve a separate database.

ZNS treats Median Time Past derived from the canonical Zcash chain as the authoritative time source for Mint-enforced protocol periods.


### 7.2 TEE security

ZNS assumes that the selected TEE correctly executes the approved Mint code, protects the Mint spending key, and provides trustworthy remote attestation. This includes enforcement of claim eligibility, authorization, lifecycle, and pricing rules, correct calculation of `expires_at`, and correct use of canonical-chain MTP for expiration, liveness, and OTP validity.

A compromise of these properties could allow the Mint policy to be bypassed or unauthorized Name Notes to be created, but it would not allow previously confirmed Name Notes to be removed or rewritten outside Zcash consensus.


### 7.3 User viewing access

ZNS assumes that the current controller retains viewing access to the Ironwood receiver of the bound Unified Address. This access is required to complete `update` and `release` authorization and to satisfy the liveness requirement. ZNS does not require or verify spending authority over that receiver.

Loss of viewing access prevents the controller from authorizing subsequent changes or satisfying the liveness requirement.

### 7.4 Price data

If registration pricing depends on external market data, ZNS assumes that the price data supplied to the Mint is available and accurate enough to apply the pricing policy. Incorrect price data can affect registration prices but cannot alter previously recorded Name Notes.

### 7.5 Protected-name access

During a protection period, ZNS assumes that access codes are issued only to authorized claimants and remain unavailable to unauthorized parties. Disclosure or improper issuance of a valid access code can allow a protected name to be claimed before the protection period ends.

### 7.6 Mint availability

ZNS assumes that the Mint remains available to evaluate requests and create required lifecycle `release` Name Notes. If the Mint becomes unavailable, existing registry state remains reconstructible, but new transitions cannot occur. An expiration or liveness deadline may be reached while the Mint is unavailable, but reaching the deadline does not itself change registry state. The registration remains in the derived registry until the required `release` Name Note is accepted on the canonical Zcash chain.

## 8 Privacy Considerations

ZNS does not provide registration privacy, resolution-query privacy, or protection against a Resolver presenting a client with stale chain state.

The Name Note account’s published full viewing key allows anyone to read the ZNS registry history, including names, `claim`, `update`, and `release` transitions, associated Unified Addresses, committed `expires_at` values when present, and predecessor references. ZNS therefore does not hide name bindings or their history.

Information outside the Name Note history may also be observable. The Mint can observe requests and authorization exchanges. A remotely queried Resolver can observe the names requested by a client. Wallet providers and network observers may observe connection metadata such as IP addresses and request timing, depending on how the client accesses ZNS.

Publishing a Unified Address as a name binding does not expose the shielded payments sent to that address or create a public transaction history for those payments.

## 9 ZNS Improvement Proposals

Protocol changes are specified through ZNS Improvement Proposals (ZNSIPs). Each ZNSIP is identified as `ZNSIP-NNN: &lt;Title&gt;` and stored as `znsip-NNN.md`, where `NNN` is assigned by the ZNSIP editors. A ZNSIP is submitted to the ZNSIP repository as a pull request. 

Following review and acceptance by the editors, the pull request is merged into the repository. Repository inclusion records the accepted proposal but does not constitute protocol activation.

The ZNSIP repository MUST maintain a public list of all active editors.

## 10 Glossary

Terms defined in the body are collected here for reference. Their normative definitions remain in the referenced sections.

| Term | Definition |
|---|---|
| **ZNS (Zcash Name Service)** | The name registry protocol specified by this document. |
| **Name Note** | An Ironwood output whose memo records a name transition, including its `expires_at` value, and whose ZNS-specific note-commitment inputs are derived from that transition; see Section 3. |
| **Transition** | A `claim`, `update`, or `release` recorded in a Name Note and represented by the tuple $(\alpha, n, u, e, p)$; see Section 3. |
| **Predecessor (`prev_rcm`)** | The `rcm` of the previously accepted Name Note for the same name, encoded as 64 lowercase hexadecimal characters. The initial `claim` uses 64 zeroes; see Section 3. |
| **Binding** | The association between a name and a Unified Address established by its accepted Name Note history. |
| **Registry state** | The set of name bindings derived from accepted Name Notes in canonical chain order; see Section 6. |
| **Name Note viewing key** | The published full viewing key for the Mint account used to create Name Notes. |
| **Name Note candidate** | A decrypted Ironwood output identified by the Resolver as a possible Name Note before all acceptance checks are complete; see Section 6. |
| **Mint** | The protocol&#39;s single registrar. It evaluates name requests under the naming policy and creates Name Notes for accepted requests; see Section 4. |
| **Mint authorization** | Authorization provided by the recognized Mint spending key and accepted subject to the attestation requirements in Section 4. |
| **Resolver** | A client that scans the canonical Zcash chain using the Name Note viewing key, verifies Name Note candidates, derives registry state according to Section 6, and provides current and historical binding state, including committed expiration values. |
| **User authorization** | The OTP procedure used to authorize an `update` or `release`. For an `update`, the OTP is bound to the resulting `(name, action, ua, expires_at)` values; see Section 5. |
| **One-time passcode (OTP)** | A six-digit decimal passcode sent by the Mint to the Ironwood receiver of the Unified Address currently bound to a name and returned to authorize an `update` or `release`; see Section 5. |
| **OTP relay memo** | An Ironwood shielded memo of the form `ZNS:otp:&lt;name&gt;:&lt;verb&gt;:&lt;ua&gt;:&lt;otp&gt;` used to deliver an OTP; see Section 5. |
| **Expiration (`expires_at`)** | The absolute Unix timestamp in whole seconds committed by a `claim` or `update` Name Note, or the exact value `none` for a registration without fixed expiration. |
| **Registration term** | A duration requested for an initial fixed-term registration or renewal. The user supplies a term; the Mint computes the resulting absolute `expires_at`. |
| **Median Time Past (MTP)** | The chain-derived time value obtained from the canonical Zcash chain and used by the Mint for protocol-defined time checks. |
| **Liveness time** | The canonical-chain MTP associated with the block containing the accepted `claim` or most recent accepted `update` for a registration. |
| **Liveness deadline** | The current liveness time plus the protocol-defined liveness interval. Reaching the deadline requires the Mint to create a `release` Name Note. |
| **ZNSIP** | A ZNS Improvement Proposal specifying a proposed protocol change; see Section 9. |


External terms inherited from the Zcash protocol specification [1] or its ZIPs are not redefined here: Ironwood action, Ironwood memo, note commitment (`cmx`), Unified Address, and incoming viewing key retain the meaning fixed by their normative sources [3, 4, 1].


## References

1. Electric Coin Company and Zcash Foundation. [Zcash Protocol Specification](https://zips.z.cash/protocol/protocol.pdf).
2. Zcash Improvement Proposal 212. [Allow Recipient to Derive Ephemeral Secret from Note Plaintext](https://zips.z.cash/zip-0212).
3. Zcash Improvement Proposal 224. [Ironwood Shielded Protocol](https://zips.z.cash/zip-0224).
4. Zcash Improvement Proposal 316. [Unified Addresses and Unified Viewing Keys](https://zips.z.cash/zip-0316).
5. S. Bradner and J. Leiba. [Key words for use in RFCs to Indicate Requirement Levels](https://www.rfc-editor.org/info/bcp14). BCP 14, RFC 2119 and RFC 8174.
6. Zcash Improvement Proposal 0. [ZIP Process](https://zips.z.cash/zip-0000).
7. zcashme. [zns-mint reference implementation](https://github.com/zcashme/zns-mint).

    


    
        
            &times;
            






    









Sign in


    
    
    
    
    
        Email
        
            
        
        
        
            
                
            
            
        
    
    
        Password
        
            
        
        
        
            
            
            
                Forgot password
            
        
    
    <div
        id="hmd-captcha"
        data-provider=""
        data-captcha-data=""
        class="flex justify-center"
        style="display: none;"
    >



    
        
    



















    
        
            
                or
                
            
        

        









    
    
        
        
            Sign in via Google
        
    
    

    <!-- A 1:1 clone of the exact dark button gsi provides. Just in case if Google is not happy with the custom button
    
    
        
        
        
            Sign in via Google
        
    
    
    -->

    
    
        
        
            Sign in via Facebook
        
    
    

    
    
        
        
            Sign in via X(Twitter)
        
    
    

    
    
        
        
            Sign in via GitHub
        
    
    
    
    
        
        
            Sign in via Dropbox
        
    
    
    
    
      
          
          
              Sign in with Wallet
          

          
              
                   Wallet
                   (
                    
                   )
              

              
          
      

      
          Connect another wallet
      
    

    
        Continue with a different method
    


const displayCount = 4
;(() => {
    const container = document.querySelector('.oauth-sign-container')
    if (!container) return
    const buttons = Array.from(container.querySelectorAll(':is(a, button).neo-btn.neo-btn-tertiary'))
    const continueWithDifferent = container.querySelector('.ui-continue-with-different')
    if (!continueWithDifferent) return
    if (buttons.length <= displayCount) return

    continueWithDifferent.classList.remove('hidden')
    for (let i = displayCount; i < buttons.length; i++) {
        buttons[i].classList.add('hidden')
    }

    continueWithDifferent.addEventListener('click', () => {
        continueWithDifferent.classList.add('hidden')
        const currentButtons = Array.from(container.querySelectorAll(':is(a, button).neo-btn.neo-btn-tertiary'))
        for (const button of currentButtons) {
            button.classList.remove('hidden')
        }
    })
})()


    

    
        
            New to HackMD? Sign up
        
    






    By signing in, you agree to our terms of service.


        
    


    
    
    
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        let userid = (document.cookie.match('(^|; )userid=([^;]*)')||0)[2];
        gtag('config', 'G-NGVZMM6DR6', {'user_id': userid});
        
    


    


  Sentry.init({ dsn: 'https://73410f1915d84abc8b2dd1f1aabd1c82@sentry.hackmd.dev/4', environment: 'production', integrations: function (intrus) { return intrus.filter(function (itr) { return itr.name !== 'TryCatch' }) } });
  const sentryUserId = document.cookie
    .split('; ')
    .map(cookie => cookie.split('='))
    .reduce((acc, [k, v]) => k === 'userid' ? v : acc, '');
  Sentry.setUser(sentryUserId ? { id: sentryUserId } : null);



    

<iframe src="https://www.googletagmanager.com/ns.html?id=GTM-KLW9Z3"
height="0" width="0" style="display:none;visibility:hidden">




    
     

    



