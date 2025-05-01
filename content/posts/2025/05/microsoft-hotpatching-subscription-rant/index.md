    ---
    title: "Microsoft's Latest Shakedown: Pay Extra to Patch Their Bugs Faster?"
    date: 2025-05-01
    draft: false
    slug: microsoft-hotpatching-subscription-rant
    tags: ["Microsoft", "Windows Server", "Security", "Licensing", "Subscription", "Hotpatching", "Rant"]
    categories: ["Technology", "Opinion", "Sysadmin Life"]
    description: "Why Microsoft charging a subscription for Windows Server Hotpatching feels like an exploitative move to profit from fixing their own bugs."
    ---

    Seriously, Microsoft? Are we doing this again? Just when you think the nickel-and-diming can't get any more blatant, they pull another rabbit out of the hat – only this rabbit demands a subscription fee for something that feels like it should be table stakes.

    I'm talking about **Hotpatching** for Windows Server 2025.

    ## What's Hotpatching? Sounds Cool, Right?

    On the surface, yeah, it sounds great. As described:

    > Hotpatching is a new way to install updates in Windows Server 2025 that does not require a reboot after installation, by patching the in-memory code of running processes without the need to restart the process

    No reboots mean faster patching. Faster patching means that "window of vulnerability" shrinks. In a world where exploits appear hours after vulnerabilities are disclosed, minimizing downtime and patch delay is *critical* security hygiene. This isn't a luxury feature; it's fundamental to keeping servers secure in a modern threat landscape.

    ## So, What's the Problem? Oh, Right. The Bill.

    Here's the punchline, delivered straight from Redmond: Starting July 1st, 2025, this essential security capability becomes a **paid subscription service**.

    Input text 2 mentions a figure floating around: **$1.5 per core, per month**.

    Sound small? Let's do some quick math. Got a server with 32 cores? That's $48/month. Got ten of those? That's $480/month. Got a hundred? You're suddenly looking at nearly **$60,000 a year** *extra*, just for the privilege of patching Microsoft's own software without scheduling downtime. For a feature that reduces the risk posed by *their* bugs.

    ## The Ethical Train Wreck

    Let's break down why this feels so wrong, echoing the points from input text 1:

    1.  **Microsoft writes software.** Like all complex software, it has bugs and security vulnerabilities. This is expected.
    2.  **Microsoft develops a way to fix these bugs faster and safer (Hotpatching).** Great! Innovation!
    3.  **Microsoft decides to *sell* this improved safety measure as an add-on.** Wait, what?

    You're telling me that the *default* state is now "remain vulnerable longer unless you pay us more"? The code for this is almost certainly sitting there on the disk whether you pay or not, just waiting for the license key.

![Microsoft Thievery](/images/microsoftupdatetheft.jpeg)

    It forces customers into a ridiculous choice:

    *   Pay the extra subscription fee (on top of existing Windows Server licenses, CALs, etc.) to patch faster.
    *   Stick with traditional patching, accept the required reboots, and hope like hell nothing exploits the vulnerability during the extended patching window.

    As someone put it:

    > Agreed. This is an absolute joke. Microsoft - look! We do security!
    > Also Microsoft - look! A nerdy little extra that finance doesn’t understand and won’t allow!

    This perfectly captures the absurdity. It's positioned as an optional extra, but the *lack* of it directly impacts fundamental security posture.

    ## Haven't We Seen This Movie Before?

    Remember the fiasco with Security Logs in 2023? Essential security data suddenly required an E5 license or a separate subscription. It took public outcry (and, cynically, a major breach) for Microsoft to backtrack partially.

    Now Hotpatching seems to be following the exact same playbook: take a critical security enhancement and slap a price tag on it. It feels less like innovation and more like exploitation – leveraging their market dominance to extract more money for fixing their own problems.

    Is this the future? Where every security improvement, every bug fix that makes patching less painful, becomes another line item on an invoice? Do we really need *another* major breach traced back to delayed patching before baseline security functions are treated as, well, *baseline*?

    This isn't just about $1.50 per core. It's about the principle. Stop selling us fixes for your own bugs, Microsoft. It's unacceptable.