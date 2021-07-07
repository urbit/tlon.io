+++
title = 'The View from the Skyway'
description = 'Urbit is an open source network. That means anyone can build software on top of it. It also means anyone can make use of Urbit’s features, like its system of scarce identities, for non-Urbit projects. But perhaps most excitingly it means there’s a lot of room for communities to discover this new world and help build it up.'
date = 2021-07-02
slug = 'view-from-the-skyway'
[extra]
author = 'Noah Kumin'
ship = '~librex-dozryc'
postimage = 'https://upload.wikimedia.org/wikipedia/commons/f/f8/Langkawi_sky_bridge.jpg'
+++

<img class="mt-8 mb-16 w-full rounded-md" alt="Landscape Home Interface" src="https://upload.wikimedia.org/wikipedia/commons/f/f8/Langkawi_sky_bridge.jpg">

Urbit is an open source network. That means anyone can build software on top of it. It also means anyone can make use of Urbit’s features, like its system of scarce identities, for non-Urbit projects. But perhaps most excitingly it means there’s a lot of room for communities to discover this new world and help build it up. 

When you populate an open source network with durable, scarce personal servers, you end up with a digital society that’s very different from the one we’re used to. Because this new digital world is so different, it can be hard to wrap your head around all of the foundational shifts it implies—or even to believe that a better life online is possible.

Personally, I used to see all the evils of the internet—manipulative ads, privacy violations, content’s race to the bottom—as social or even metaphysical problems. But a study of the history of the internet and of the Urbit network helped me to see that these are technical problems that have technical solutions. Once I realized this, I started to feel a lot more optimistic about the internet and about the future of our digital society in general.

The aim of this post is to outline some of  the solutions the Urbit network can provide . The first two are already being built. We hope that you, the Urbit community, might want to help build the rest.

This post will discuss:

1. Urbit as Skyway (a metaphor to help understand the Urbit network) 
2. Urbit and Bitcoin (a payments system currently being built)
3. Urbit and WebRTC (a system for real-time communications apps such as video chats, which is currently being built)
5. Urbit and Marketplaces (how Urbit could help people trade goods)
6. Urbit and Governance (how Urbit could be used for alternate forms of governance)
7. Urbit, Tlon, and You


## 1. Urbit as Skyway

This is what today’s internet would be like if it were a physical place:

You live on 161st Street, and you want to go hang out with your friend on 207th Street. The obvious thing to do would be to travel straight uptown. But this isn’t an option. Instead, you have to take the MEGACORP highway all the way down to 42nd Street, then make a U-turn and head up to 207th Street from there. You’ve heard stories that it might be possible to go straight from 161st to 207th. But the journey would be dangerous and complex. The roads are bad and the visibility is even worse. Highway robbers lurk behind the bushes. It’s as though someone had smashed all the streetlamps and let all the old paths grow wild, so it would appear that all roads lead to MEGACORP. 

Actually, they don’t. It’s just that the city’s infrastructure has got so tangled that only MEGACORP monopolies have the resources to make the place easily navigable. And they’ve used their monopolies to anoint themselves providers of all the other services, too. Since they own all the roads, it was a cinch for them to become the sole purveyors of services people might use the roads for.

Want to travel somewhere with a six pack that has to stay cold? MEGACORP has a monopoly on ice boxes. Want to order a motorbike? They’ve got all the trucks to load them into. Want to send an antique? You should see their stock of bubble wrap. In a way, it’s convenient. The trade-off for this “convenience” is that you’re now locked into a system in which you have no privacy, the terms of your agreement can be changed arbitrarily, and you’ve signed over your mind to a lifetime bombardment of invasive advertisements.

The Urbit approach is not to try to save all this old infrastructure, but to encourage companies and individuals to work together to build a [skyway](https://en.wikipedia.org/wiki/Skyway) on top of it. This is a system of new roads, independent of whatever MEGACORP is doing down below. Here, the incentives are fundamentally different. Back on ground level, the businesses that could succeed were the ones that did the best job of corralling all the travelers onto a single road with a few different exits. But up here, different portions of the skyway will be owned and developed by different individuals and communities. Some communities might build skyway infrastructure that snakes its way all over the city, while others will want to build infrastructure that’s more local. The end result is something that empowers individuals and communities to see the whole system of roads and services as a set of tools to help them get around the city and do what they want to do—as opposed to a monolithic entity that is designed to control their behavior.

This probably sounds pretty ambitious. We sometimes hear versions of the question “Is this really the paradigm shift the enthusiasts are talking about, or just a fun new toy?” This is a reasonable question to ask about Urbit in 2021. It was also a reasonable question to ask about the internet in the ‘80s and early ‘90s. In both cases, the answer to the question depends on how far down the rabbit hole you’re prepared to go.

## 2. Urbit and Bitcoin

Despite their convenience, there are real problems with the way online payments work today. 

If you want to spend money online, you’re relying on an unwieldy tangle of banking apps and payment gateways, and you’re relying on them not to [rug-pull](https://nymag.com/intelligencer/2021/01/robinhood-ban-gamestop-share-price-explained.html) you. If you’re a merchant who wants to collect money online, you’re handing over goods for credit, without receiving up-front payment for your goods. This makes it surprisingly easy for customers to defraud you: the financial impact of “chargebacks” is [projected](https://markets.businessinsider.com/news/stocks/friendly-fraud-expected-to-top-130-billion-in-2020-chargebacks-hurting-merchants-and-consumers-1028959185) to be around $130 billion by 2023. And then there’s the fact that payment processor and payment gateway companies each take a cut out of whatever business you’re doing—all the more so if you’re transacting across borders.

But what if there were a single currency that anyone in any country could use, and what if all its transactions were peer-to-peer, so that there were no middlemen to take a cut? Bitcoin offers just such a peer-to-peer currency solution, and Bitcoin on Urbit offers a trusted network of peers and easy-to-use tools for transacting with them. To make and receive Bitcoin payments on Urbit, you can associate a Bitcoin full node with your Urbit ship, or you can make use of a neighboring ship’s full node to broadcast transactions along with your public balance. 

Unlike MEGACORP services like Cash App or Paypal, this is a tool that lets you directly connect to Bitcoin full node. Also unlike those services, it’s a tool that’s meant to be run by individuals. Think of the difference between leaving your valuables with a trusted friend and handing over your cash to a money manager who will use your funds to purchase exotic financial instruments that you’re not meant to understand.

This is just the beginning of Bitcoin and Urbit. With integration of Bitcoin’s Lightning Network [underway](https://grants.urbit.org/bounties/46306157-volt-lightning-on-urbit), frictionless, programmatic small-scale consumer payments are on the horizon. On the legacy internet, programmatic event firing (i.e., you automatically make or receive a payment based on some event written in code) is the ingredient that allowed e-commerce to take over the world. 

When anyone with an urbit can perform this behavior, that means anyone with an urbit has the same power that payment gateway companies like Stripe and Square have. With an Urbit identity, you’ll be able to accept payments for your small business, send money across borders without exchange fees, or receive subscription-based payments for content creation. 

This past decade, we got used to the idea that if you want to do commerce, you need some big company to handle payments for you. But back when cash was king, you could simply sell your goods to people, without global finance getting directly involved. All you needed was a cash register and a ledger. Bitcoin on Urbit combines the simplicity of the cash register with the futuristic promise of easy-to-use, instant bankless payments across borders.

## 3. Urbit and WebRTC

This is a case where we can take software from the Old World and put it to new use on Urbit’s skyway infrastructure. WebRTC is real-time communications software, used by audio/video chat services such as Google Meet, Facebook Messenger, and Discord. It utilizes specific servers, known as ICE servers, to initialize the connection between one person and another.

Now with Urbit’s WebRTC integration (shout out to Edward Amsden, a.k.a <span class="font-mono text-base">~ritpub-sibsyl</span> for his work on the project), we have the infrastructure in place for truly peer-to-peer WebRTC applications. Just as many different infrastructure nodes (a.k.a. stars) on Urbit might run Bitcoin nodes, making for a network that’s both decentralized and robust, many different stars might also run ICE servers, providing robust, decentralized architecture for audio and video calls (and much more) between different Urbit identities. This is a pattern that is general across all services that might run on Urbit: instead of relying on one giant corporation for a particular service, you get to choose between smaller local cooperatives. And you get to choose the one that works best for you.

WebRTC apps on Urbit would mean that the identity and signaling functions usually taken care of in a centralized way, by a Google or Facebook, are now peer-to-peer. The Urbit network provides the protocol for choosing which peers you wish to interact with, while a WebRTC app on Urbit could facilitate real-time audio or video communication, real-time gaming, file-sharing, and more. Most of us already participate in at least some of these peer-to-peer activities. But we tend to do so in a weird way where we’ve got a big global corporation acting as the middleman. What happens when the middleman disappears? 

In truth, we don’t entirely know. But with the hard problem of decentralization taken care of, there’s now a new universe of real-time communication app development for engineers to explore. The huge success of platforms like Discord and Twitch has shown the immense power of real-time communication: any place where people can talk to each other in real time is likely to win out over a place where they can’t. But already these MEGACORP platforms are stumbling over familiar controversies such as ‘what kind of content is allowed, and who gets to decide?’ 

These are problems with non-obvious solutions, which is why different groups can arrive at different reasonable answers. But when these platforms become decentralized and peer-to-peer, instead of unilaterally controlled by a single corporate entity, the fact there are multiple answers becomes a source of strength for the network, not a poison dart that brings it to its knees. 

 
## 4. Urbit and Identity

Think about the implications of this: In March 2021 it turned out that popular twitter user @azusagakuyuki, a young Japanese woman who posted selfies documenting her motorcycle travels, was actually a middle-aged man. That is, a middle-aged man accrued a social media following by posting pictures, using FaceApp, that made him look like a young woman. 

As Balaji Srinivasan [pointed out](https://twitter.com/balajis/status/1383819821930868746?s=20), pretty soon meatspace identities are going to be so easily deepfakeable that they’re not worth much. Even today the difference in content between, let’s say, Kim Kardashian’s Instagram account, and a Kim Kardashian fan account, is pretty negligible. Imagine how much more negligible, once anyone can create video content of a human that looks and sounds exactly like Kim Kardashian. Pretty soon, we’ll all be authors of our own meatspace fan fiction. The only nonfiction versions of our lives might be the ones encoded in bits.

The header of this post says that I’m Noah Kumin. That may or may not be true, as far as you’re concerned. I could, for instance, be [several dogs](https://i.imgur.com/uZDk7ZU.jpg) stacked on top of each other in a trench coat. But one thing that’s absolutely certain is that on Urbit I’m <span class="font-mono text-base">~librex-dozryc</span>. That fact is cryptographically attested any time another ship on Urbit interacts with me. The implications are pretty clear. In the future, as Srinivasan points out, the reputations we accrue on cryptographically verifiable identities are going to be far more important than the reputations we accrue with identities that can be easily spoofed, shadowbanned, or deleted. 

Digital identity will be useful anywhere real-life identity was useful in the past. The first great web3 social network will need a cryptographic system like Urbit’s. Smart contract oracles will require verifiable digital identities in order to bring real-world information on chain. Polls and voting systems will require verifiable digital identity to ensure that their results aren’t being gamed. Proving ownership of NFTs from various different blockchains will require a single digital identity with which they can all be associated. An Urbit digital identity is like a social security number—only globally useful, cryptographically signed, and less [susceptible](https://www.npr.org/sections/alltechconsidered/2015/06/15/414618292/theft-of-social-security-numbers-is-broader-than-you-might-think#:~:text=He%20estimates%2060%20percent%20to,federal%20employee%20is%20a%20victim.) to theft. 

## 5. Urbit and Marketplaces

Because of their ubiquity, we sometimes imagine online marketplaces like Amazon or Alibaba to be robust, but actually these web platforms are fragile. It doesn’t take much for a service (remember MySpace?) to get wiped out by new tech or decaying infrastructure. If you’re a vendor and your marketplace of choice gets wiped out, then all the reputation you’ve accrued as a seller gets wiped out too. 

Another major problem: these marketplaces have made a devil’s bargain with their vendors and customers. That is, in the beginning, an online marketplace desperately wants to acquire vendors, so that it can attract customers. But eventually it becomes a competitor with its vendors and seeks to squeeze them out. Similarly, such a platform begins by providing as many services as possible to customers. Once the platform has locked in its customers, it pivots to manipulating them to retain their engagement. 

One last existential problem for these platforms: they each take a cut of whatever profit the seller makes. That’s not an issue for them now, as sharing profits with your online marketplace is the only game in town for online vendors. But there’s a strong case to be made that these seller fees will become increasingly untenable, as marketplaces scale them up to offset the inevitable slowdown of their user base growth. 

Decentralized commerce built on top of Urbit wouldn’t just be cool tech. It would offer an escape hatch from the problems listed above. Imagine this: It’s the year 3,000 AD. Amazon and Alibaba, eBay and Etsy, have long been forgotten. But reputation built on Urbit has been passed down from family to family for a thousand years. That reputation extends across different decentralized marketplaces on the Urbit network. Your reputation stays consistent, but the marketplaces don’t. Any time a marketplace tries to game the system by tweaking the algorithm to hurt its vendors, or charging exorbitant fees, a new marketplace springs up. Yet each of these new marketplaces respects the reputation that you, the buyer-seller, have accrued on the network. (If you’ve got a black sheep in the family who has brought down the reputation in the past thousand years, likely there’s a marketplace that will agree to look only at transactions made over the last decade, or the last year.)

Now imagine that the proliferation of these different marketplaces has fundamentally changed the consumer experience for anyone who wants to buy stuff on the internet. Anyone with a computer has the ability to sell something, and anyone with a computer has the ability to buy it directly from that person. This is a bit like Craigslist, a bit like Etsy or eBay. But the difference is that individual buyers and sellers are the ones at the wheel, not the marketplaces that have corralled them as “users” onto one big server. That means that marketplaces have to adapt to people, instead of the other way around. Maybe the heterogeneity of marketplaces even tilts the world more toward a bazaar-like orientation, in which artisanally crafted goods, available only locally, win out over superstore mass-produced mediocrity.

This is an ambitious way of thinking. But the fact remains that solutions to the big problems with online marketplaces exist on Urbit. The problem of platform decay gets solved by the fact that Urbit IDs are built for permanence. The problem of lock-in gets solved by infrastructure that always allows for exit. And the problem of untenable seller fees gets solved by a decentralized network that naturally encourages platforms and vendors to focus on products above all else.

## 6. Urbit and Governance

From the beginning, Urbit users took to calling themselves Martians. It’s mostly tongue-in-cheek, but it’s also not a bad analogy. Like the literal planet Mars, Urbit is a place where it took some intrepidness and big-picture thinking to stake out a place early on. Also like the planet, Urbit is a place where there isn’t a lot of history. A civilization on the planet Mars might be able to slough off a lot of Earth baggage. A civilization on Urbit not only sloughs off a lot of the bad tech decisions from the last few centuries, but it also provides a lot of digital land on which new structures can be built. 

If you wanted to build a true social network or governance network in 2021, one of the first obstacles you’d run into is scaling server space as your network grows. But if you’re creating one of these things on Urbit, you can harness the computing power of everyone on the network. After all, Urbit itself is *composed* of servers. Scaling Urbit will still require a good amount of work, which kernel developers will take on collectively. But if you’re just building a social app on top of the Urbit network, you won’t have to worry about the costs of server space for storing all of your users’ data. This cuts out what can be both a major cost and a major time-suck, and should give you and your team of developers more time and resources to focus on features.

Or let’s say you’re creating social governance software for a neighborhood or small town. In that case, Urbit’s identity system gets you immediately to a place where you can tie a person’s digital identity to his or her real-world identity. And this can be done while preserving privacy: you can attest to living in a certain zip code to vote on a local ordinance, for example, without revealing anything else about yourself. An even bigger win is that any Urbit ship is truly personal. Government tools running on centralized data servers have a single point of attack where its citizens can be compromised. When every citizen’s data lives on his or her own server, that’s a level of robustness that digital governing systems have not seen before. 

Protocols such as *one person, one vote* can be difficult for even resource-rich governments to institute when they require voters to show up in person. But trying to institute that protocol on the current web stack is even sketchier. You’re never going to vote on Facebook, for instance, or any such place where identity is free and fake accounts run wild. But with Urbit, you’ve got a unique personal computer that’s cryptographically verifiable as belonging only to you. That certainly lays the foundation for any organization that wants a secure and transparent way to tally votes over the internet.


## 7. Urbit, Tlon, and You

Tlon is the first company to build popular software on top of Urbit. That’s only natural, because building software on Urbit was part of Tlon’s founding mission, and because the company was founded at a time when not that many people even knew what Urbit was.

But it was also Tlon’s founding mission to gradually hand over Urbit to the Urbit community. Inch by inch, row by row, we’re starting to see that happen. There’s been far more community development on the Urbit network this past year than ever before, and the biggest new contributions are no doubt still to come. The idea is that some day Tlon becomes just another prosperous company building software and selling services on Urbit.

Urbit enthusiasts tend to have an understated vibe—perhaps as an antidote to the more lambo-centric appetitiveness that can be found in certain web3 spaces. (Maybe that’s because Urbit [is actually web4](https://twitter.com/urbit/status/1402804465741172736).) But don’t let the calmness fool you. These are exciting times to be on the network. Right now Urbit is a land of homesteaders: people who are self-motivated, creative, thoughtful, and jazzed up about the prospect of creating something genuinely new. If that sounds like you, and you haven’t been on the network yet, then it’s probably time for you to take a gander. For one thing, there are a bevy of high quality public groups out there, on subjects from cryptocurrency to philosophy to carpentry to pre-1990 pop music from Europe and Asia. There’s still a ways to go before Urbit groups achieve the sheer breadth of what you might find on the legacy internet. But that may not be entirely a bad thing. As one new Urbit pilot [put it](https://twitter.com/urbitcommunity/status/1403170529691914244?s=20), “this is like exclusively high quality twitter.”

But the Urbit network isn’t just a place to hang out. It’s a place to build. Like the early inhabitants of a new country, we need energetic people who are ready to get to work. This means engineers, of course. But it also means artists, writers, podcasters, researchers—anyone who wants to bring value to the network. Justin Murphy has already [laid out](https://otherlife.co/urbit/) a thorough case for why creators might want to abandon the current frankenstack of legacy internet apps in favor of Urbit. And we’ve got an active [grants program](https://grants.urbit.org/) for doling out address space to those who have something to contribute. 

So come have a look. Urbit might feel a little strange when you first arrive, as all new places do. In fact, it may not feel like the internet at all. That’s because it’s not. It’s the internet the way it was always supposed to be.