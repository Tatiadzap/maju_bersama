<script lang="ts">
	import { useTransform, useViewportScroll } from 'svelte-motion';
	import GoogleGeminiEffect from '$lib/components/effects/google-gemini-effect/GoogleGeminiEffect.svelte';

	let ref: HTMLDivElement;

	const { scrollYProgress } = useViewportScroll();

	const pathLengthFirst = useTransform(scrollYProgress, [0, 0.8], [0.2, 1.2]);
	const pathLengthSecond = useTransform(scrollYProgress, [0, 0.8], [0.15, 1.2]);
	const pathLengthThird = useTransform(scrollYProgress, [0, 0.8], [0.1, 1.2]);
	const pathLengthFourth = useTransform(scrollYProgress, [0, 0.8], [0.05, 1.2]);
	const pathLengthFifth = useTransform(scrollYProgress, [0, 0.8], [0, 1.2]);
</script>

<div
	class="relative h-[400vh] w-full overflow-clip rounded-md pt-40 pb-20 dark:border dark:border-white/[0.1]"
	bind:this={ref}
>
	<GoogleGeminiEffect
		pathLengths={[
			pathLengthFirst,
			pathLengthSecond,
			pathLengthThird,
			pathLengthFourth,
			pathLengthFifth
		]}
    title = "Memberdayakan Potensi, Mewujudkan Kesempatan"
    description = "Dukungan karir dan pelatihan keterampilan bagi individu dengan disabilitas"
    button = "Mulai Sekarang"
	/>
</div>

<div class="max-w-[900px] mx-auto text-lg py-20">
  <p class="text-center">Kami berkomitmen untuk menjembatani kesenjangan antara potensi dan kesempatan, memberikan pelatihan keterampilan yang disesuaikan, dukungan karir pribadi, dan kesempatan penempatan kerja bagi individu dengan disabilitas.</p>
</div>
