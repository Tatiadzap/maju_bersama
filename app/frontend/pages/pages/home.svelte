<script>
  export let ignoreStyles = true; // Default to true or set as passed from Layout

  import CtaSection from '$lib/components/landing/CtaSection.svelte';
  import HeroSection from '$lib/components/landing/HeroSection.svelte';
  import BenefitsSection from '$lib/components/landing/Benefits.svelte';
  import HowItWorksSection from '$lib/components/landing/HowItWorks.svelte';
</script>

<div class={ignoreStyles ? '' : ''}>
  <HeroSection />
  <HowItWorksSection/>
  <BenefitsSection/>
  <CtaSection />
</div>
