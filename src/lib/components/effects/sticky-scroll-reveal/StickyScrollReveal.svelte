<script lang="ts">
	import { onMount, onDestroy } from 'svelte';

	let activeCard = 0;
	let backgroundColorsLight = ['#DBB3FF', '#F94F01', '#D3FB53', '#F3F4FA'];
	let linearGradients = [
		'linear-gradient(to bottom right, var(--cyan-500), var(--emerald-500))',
		'linear-gradient(to bottom right, var(--pink-500), var(--indigo-500))',
		'linear-gradient(to bottom right, var(--orange-500), var(--yellow-500))'
	];

	export let content

	let ref: HTMLDivElement;

	function calculateActiveCard() {
		const scrollPosition = window.scrollY;
		const cardElements = Array.from(ref.querySelectorAll('.content-card'));

		cardElements.forEach((card, index) => {
			const cardTop = card.getBoundingClientRect().top + scrollPosition;
			const isCardVisible = scrollPosition >= cardTop - window.innerHeight / 2;

			if (isCardVisible) {
				activeCard = index;
			}
		});
	}

	onMount(() => {
		calculateActiveCard(); // Initial calculation

		window.addEventListener('scroll', calculateActiveCard);
		window.addEventListener('resize', calculateActiveCard);

		return () => {
			window.removeEventListener('scroll', calculateActiveCard);
			window.removeEventListener('resize', calculateActiveCard);
		};
	});
</script>

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 159" fill="none"><path d="M0 159C315.5 5.15521 1426.5 -104.214 1440 159H0Z" fill="#DCB3FF"></path></svg>
<div
	bind:this={ref}
	class="relative flex justify-evenly px-10 py-32 space-x-10"
	style="background-color: {backgroundColorsLight[activeCard % backgroundColorsLight.length]}; transition: background-color 0.5s ease-in-out; min-height: 100vh;"
>
	<!-- Left side content -->
	<div class="space-y-[60vh] flex-1 max-w-md">
		{#each content as item, index (item.title + index)}
			<div class="my-20 content-card">
				<h1>
					{item.title}
				</h1>
				<p class="text-lg mt-10">
					{item.description}
				</p>
			</div>
		{/each}

		<div class="h-40" /> <!-- Add some bottom padding to avoid abrupt stop -->
	</div>

	<!-- Right side sticky centered box -->
	<div
		class="sticky top-[calc(50%-10rem)] h-60 w-80 overflow-hidden rounded-md bg-white flex-1 max-w-md"
		style="background: {linearGradients[activeCard % linearGradients.length]};"
	>
		<!-- Box content goes here -->
	</div>
</div>
