<script lang="ts">
	import { ArrowRightIcon } from 'lucide-svelte';
	import AnimatedShinyText from '$lib/components/magic/AnimatedShinyText/AnimatedShinyText.svelte';
	import BorderBeam from '$lib/components/magic/borderbeam/BorderBeam.svelte';
	import Button from '$lib/components/ui/button/button.svelte';
	import type { ObserverEventDetails } from 'svelte-inview';
	import { inview } from 'svelte-inview';

	// Images
	import HeroDarkImg from '$lib/imgs/hero-dark.png';
	import HeroLightImg from '$lib/imgs/hero-light.png';
  import IndonesianSmiling from '$lib/imgs/indonesian-smiling.png'
	let inView = false;
	const handleChange = ({ detail }: CustomEvent<ObserverEventDetails>) => {
		// console.log(detail);
		inView = detail.inView;
	};
</script>

<section id="hero" class="relative mx-auto mt-32 max-w-7xl px-6 text-center md:px-8">

	<h1
		class="-translate-y-4 animate-fade-in text-balance bg-gradient-to-br from-black from-30% to-black/40 bg-clip-text py-6 font-medium leading-none tracking-tighter text-transparent opacity-0 [--animation-delay:200ms] dark:from-white dark:to-white/40 sm:text-6xl md:text-7xl lg:text-8xl"
	>
    Memberdayakan Potensi
		<br class="hidden md:block" />
		{' '}
		Menciptakan Kesempatan
	</h1>
	<p
		class="mb-12 -translate-y-4 animate-fade-in text-balance text-lg tracking-tight text-gray-400 opacity-0 [--animation-delay:400ms] md:text-xl"
	>
    Kami mendukung individu dengan disabilitas melalui pelatihan keterampilan yang disesuaikan, dukungan karir pribadi, dan kesempatan kerja yang inklusif.
	</p>
	<Button
		class="-translate-y-4 animate-fade-in gap-1 rounded-lg text-white opacity-0 ease-in-out [--animation-delay:600ms] dark:text-black"
	>
		<span>Mulai Sekarang - Gratis </span>
		<ArrowRightIcon
			class="ml-1 size-4 transition-transform duration-300 ease-in-out group-hover:translate-x-1"
		/>
	</Button>
	<div
		use:inview={{
			unobserveOnEnter: true,
			rootMargin: '-100px'
		}}
		on:inview_change={handleChange}
		class="relative mt-32 animate-fade-up opacity-0 [--animation-delay:400ms] [perspective:2000px] after:absolute after:inset-0 after:z-50"
	>
  <div class="mx-auto relative w-full max-w-[720px] aspect-[1/1]">
    <div class="absolute inset-0 bg-gray-300 rounded-full overflow-hidden">
      <img
        src={IndonesianSmiling}
        alt="HeroLightImage"
        class="w-full h-full object-cover"
      />
    </div>
  </div>


	</div>


</section>
