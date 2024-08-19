<script>
	import { Motion } from 'svelte-motion';
  import { LampEffect } from '$lib/components/effects/lamp-effect';
  import { Button } from "$lib/components/ui/button"
  import { ArrowRightIcon } from 'lucide-svelte';

</script>

<LampEffect>
  <Motion
    let:motion
    initial={{ opacity: 0.5, y: 100 }}
    animate={{ opacity: 1, y: 0 }}
    transition={{
        delay: 0.3,
        duration: 0.8,
        ease: 'easeInOut'
    }}
  >
    <h2
        use:motion
        class="mt-8 bg-gradient-to-br from-slate-300 to-slate-500 bg-clip-text py-4 text-center text-4xl font-medium tracking-tight text-transparent md:text-7xl"
    >
      Mulai Perjalanan Karir  <br /> Anda Hari Ini!
    </h2>
  </Motion>

  <Button href="/sign_up"
    class="mt-6 -translate-y-4 animate-fade-in gap-1 rounded-lg text-white opacity-0 ease-in-out [--animation-delay:600ms] dark:text-black"
  >
    <span>Mulai Sekarang - Gratis </span>
    <ArrowRightIcon
      class="ml-1 size-4 transition-transform duration-300 ease-in-out group-hover:translate-x-1"
    />
  </Button>

</LampEffect>
