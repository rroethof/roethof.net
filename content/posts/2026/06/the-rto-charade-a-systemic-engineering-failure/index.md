---
title: "The RTO Charade: A Systemic Engineering Failure"
slug: the-rto-charade-a-systemic-engineering-failure
date: 2026-06-12
lastmod: 2026-06-13
draft: false
author: "Ronny Roethof"

categories:
- career-sysadmin
- opinion-reflections

tags:
- burnout
- rto
- workplace-engineering
- systems-thinking
- autonomy

summary: "Return-to-office mandates are a systemic failure. Treating human infrastructure with the same flawed logic as bad server maintenance is why IT is burning out."
description: "Forced RTO is not about collaboration. It is a failure of management to understand basic systems engineering and the reality of modern work."
---

### The RTO Charade: A Systemic Engineering Failure

The return to office movement is a masterclass in failed system design. As Olga Maksymova recently pointed out in [her analysis](https://www.linkedin.com/posts/olga-maksymova_rto-remotework-burnout-share-7469680428740747265-a1Gp), we are witnessing a forced regression that ignores everything we learned about efficiency. Management mandates are not driven by collaboration. They are driven by an outdated, lazy need for surveillance and the inability of managers, who feel lonely at home, to cope with the shift to remote work. When you force engineers back into noisy offices to sit on Teams calls, you are not building culture. You are creating a professional nightmare to soothe someone else's ego.

#### The Pandemic Paradox
Before COVID we had a hybrid balance. Then the pandemic hit. During my time at the RIVM office presence was out of the question. It was dangerous and irresponsible. If we as RIVM employees had flocked to the office it would have been a national scandal. We had to lead by example. Working from home was the only ethical standard for safety and continuity. 

I started at the kitchen table with my son doing home-schooling and hanging off my chair while I was trying to solve critical infrastructure issues. Every parent recognizes this image. It was chaos, but it was also the turning point. I quickly realized that to sustain this, I needed to treat my home workspace with professional rigor. I invested in a triple-display setup, a docking station and eventually my [ZSA ergonomic keyboard](/posts/2025/03/my-quest-for-ergonomic-bliss-a-journey-to-find-a-split-keyboard-that-works-with-tietses-syndrome/).

This setup is no longer a luxury. It is the baseline for my professional output. Once that was in place, the results were undeniable. Work continued and output was high. I discovered I was far more effective as an engineer in my own controlled environment than I ever was in the constant, soul-crushing noise of the office. Now, forced RTO mandates mean I have to pack up this essential gear and drag it around like a hardware nomad. It is an absolute drama that serves no technical purpose. It forces a significant, unnecessary degradation of the professional environment required for high-level engineering.

#### From Hybrid Norm to Forced Regression
After the pandemic hybrid work became the rational norm. But now years later there is an aggressive thoughtless push. It is no longer about hybrid. The bar is being set at three or four days a week.

Organizations are trying to turn back the clock while the reality on the ground has changed. An office that used to be a 45 minute drive away has been moved to a location that now requires a 2 hour commute. This is not a return to work. It is a fundamental breach of operational logic. 

As engineers we solve problems. RTO is a bottleneck that serves no purpose other than control. It is a classic example of technical debt in organizational design mirroring Conway’s Law. The organization is just reflecting a broken obsolete communication structure.

* The Virtualization Void: We are IT professionals. Our infrastructure lives in datacenters or the cloud, shielded by VPNs and Zero Trust tunnels. The days of the local server rack in a hallway closet are long gone. Forcing us to commute to a location to access a digital resource that is geographically agnostic is technically illiterate. It is pure theater.
* The Teams Paradox: We reintroduce physical co-location while using remote protocols. It is a technical disaster. You hear your colleague speak next to you while the delayed audio hits your headset. It is inferior, distracting and honestly just plain stupid.
* The Geographic Absurdity: Moving an office so that your engineers spend 4 hours a day in traffic is not return to office. It is a deliberate erosion of your team's time, health and energy. When this was demanded of me I drew a line. My role allowed for remote work and my output proved it was the only logical choice.

#### The Open-Plan Fallacy
As Chris Dorsman rightly pointed out, there is a mountain of studies confirming that open-plan offices are fundamentally ineffectual and damaging to employee health. It is baffling that this is not a major Arbo-issue.

Research from TU Delft and TU Eindhoven consistently confirms the fallout. High-density environments lead to significant declines in cognitive performance and well-being. Studies demonstrate that open-plan workers suffer from higher stress levels, increased fatigue and a marked decline in privacy. A key Dutch study indicates that the loss of focus caused by background noise and visual interruptions is not just a productivity killer. It is a long-term health risk.

The mandate is a structural contradiction. You cannot demand high-level analytical output while forcing engineers into an environment proven to degrade concentration and well-being. It is a fundamental mismatch. You are managing for visibility at the cost of actual performance and individual safety.

This is not just about efficiency for me. It is about physical stability. Being forced into an office where I have no control over my ergonomics or climate is unworkable. I rely on noise-canceling headphones to enter my zone. When someone taps me on the shoulder while I am fully focused, I hit the ceiling. As a heart patient, that is not a joke. That is a direct trip to the ECG. It is nerve-wracking even as a memory. When the system forces me into a state of constant physiological alarm, it is not just bad management. It is a violation of the basic conditions required for me to do my job without risking my health.

### Further Reading (Stable Dutch Research Base)
* [TU Delft: Office design, privacy, and workplace satisfaction](https://research.tudelft.nl/en/publications/interior-design-features-predicting-satisfaction-with-office-work/) (Peer-reviewed research repository).
* [TU Eindhoven: Open-plan offices, noise and perceived productivity](https://pure.tue.nl/ws/files/182722713/10_1108_JMP_09_2019_0526.pdf) (Field studies in Dutch organizations).
* [TU Delft: Flexible workplaces, productivity and satisfaction](https://pure.tudelft.nl/ws/files/39388709/2004_JCR_VanderVoordt_Productivity_Satisfaction_Flexible_Workplaces.pdf) (Building and workplace research).
* [TNO: Workplace health, environment and work conditions](https://www.tno.nl/en/work-health-work-environment/) (Dutch occupational research domain).

#### The Constraint Case
My transition proved that professional output and personal stability are interdependent. For those of us balancing professional work with intensive caregiving for my partner with MS and my autistic son, flexibility is not a luxury. It is a core requirement.

This is not an edge case. It is a system constraint that RTO policies ignore. Forcing a design built for an ideal worker, one without any real-world responsibilities, is a design flaw. When management mandates presence they ignore that human resilience is a hard limit. After 4 hours in traffic your ability to function is depleted, not just your capacity to work.

#### Reference Architecture: How to Actually Scale
If we want functional organizations we need to treat workplace engineering with the same rigor as systems engineering. Stop the presence-based compliance and move to an output-based architecture:

1. Output-based evaluation: Measure results, not seat time. Adopt SRE-style SLOs for delivery rather than monitoring physical presence.
2. Asynchronous default: If a task requires synchronous interaction, define the specific runtime for that activity. Otherwise stop forcing meetings.
3. Specialized environments: The office should function as a specialized runtime environment for activities that specifically require physical co-location. It is not a default destination.

### Conclusion
If we maintained our server infrastructure with the same flawed logic we apply to our human infrastructure, prioritizing compliance over resilience, we would be fired for negligence. 

If the current design leads to system failure, it is not the engineers who need to change. The system does. Stop the mandates. Focus on results. Build environments where people can actually function.