<script lang="ts">
	import { useAnimation, Motion } from 'svelte-motion';
	import { inview } from 'svelte-inview';
	import type { ObserverEventDetails, ScrollDirection, Options } from 'svelte-inview';
	import { cn } from '$lib/utils';
	import { onMount } from 'svelte';
	export let id: string = crypto.randomUUID().slice(0, 6);
	let controls = useAnimation();
	let inView = false;

	const handleChange = ({ detail }: CustomEvent<ObserverEventDetails>) => {
		inView = detail.inView;
	};

	$: {
		if (inView) {
			controls.start({
				opacity: 1,
				transition: { delay: Math.random() * 2, ease: 'easeOut', duration: 1 }
			});
		}
	}
</script>

<Motion initial={{ opacity: 0 }} animate={controls} let:motion>
	<div
		{id}
		use:inview={{
			rootMargin: '-50px',
			unobserveOnEnter: true
		}}
		on:inview_change={handleChange}
		use:motion
		class={cn(
			'relative size-20 cursor-pointer overflow-hidden rounded-2xl border p-4',
			// default light mode styles (previously dark mode)
			'bg-transparent [border:1px_solid_rgba(255,255,255,.1)] [box-shadow:0_-20px_80px_-20px_#ffffff1f_inset]',
			// dark mode styles (previously light mode)
			'dark:bg-white dark:[box-shadow:0_0_0_1px_rgba(0,0,0,.03),0_2px_4px_rgba(0,0,0,.05),0_12px_24px_rgba(0,0,0,.05)]'
		)}
	>
		<slot></slot>
	</div>
</Motion>
