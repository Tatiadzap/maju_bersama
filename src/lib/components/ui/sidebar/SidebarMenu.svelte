<script lang="ts">
  import SidebarItem from './SidebarItem.svelte';
  import { cn } from '$lib/utils.js';

  export let currentSection: string;
  export let onSectionChange: (section: string) => void;
  export let sections: Array<{ href: string, title: string }> = []; // Dynamic sections

  function handleSectionChange(href: string) {
    onSectionChange(href);
  }
</script>

<nav class={cn("flex space-x-2 lg:flex-col lg:space-x-0 lg:space-y-1 w-250[px]")}>
  {#each sections as { href, title }}
    <SidebarItem
      href={href}
      title={title}
      isActive={currentSection === href}
      onClick={() => handleSectionChange(href)}
    />
  {/each}
</nav>
