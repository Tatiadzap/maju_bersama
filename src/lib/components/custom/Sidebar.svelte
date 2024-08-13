<script lang="ts">
  import { cubicInOut } from 'svelte/easing';
  import { crossfade } from 'svelte/transition';
  import { cn } from '$lib/utils.js';
  import { Button } from '$lib/components/ui/button';

  export let currentSection: string;
  export let onSectionChange: (section: string) => void;
  export let sections: Array<{ href: string, title: string }> = []; // Dynamic sections

  const [send, receive] = crossfade({
    duration: 250,
    easing: cubicInOut,
  });

  function handleSectionChange(section: string) {
    onSectionChange(section);
  }
</script>

<nav class={cn("flex space-x-2 lg:flex-col lg:space-x-0 lg:space-y-1 w-250[px]")}>
  {#each sections as item}
    {@const isActive = currentSection === item.href}
    <Button
      on:click={() => handleSectionChange(item.href)}
      variant="ghost"
      class={cn(
        !isActive && "hover:underline",
        "relative justify-start hover:bg-transparent"
      )}
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
        {item.title}
      </div>
    </Button>
  {/each}
</nav>
