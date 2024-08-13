<script lang="ts">
  import { cubicInOut } from 'svelte/easing';
  import { crossfade } from 'svelte/transition';
  import { Button } from '$lib/components/ui/button';

  export let href: string;
  export let title: string;
  export let isActive: boolean;
  export let onClick: () => void;

  const [send, receive] = crossfade({
    duration: 250,
    easing: cubicInOut,
  });
</script>

<Button
  on:click={onClick}
  variant="ghost"
  class="relative justify-start hover:bg-transparent"
  data-sveltekit-noscroll
>
  {#if isActive}
    <div
      class="absolute inset-0 rounded-md bg-muted"
      in:send={{ key: "active-sidebar-tab" }}
      out:receive={{ key: "active-sidebar-tab" }}
    />
  {/if}
  <div class="relative">
    {title}
  </div>
</Button>
