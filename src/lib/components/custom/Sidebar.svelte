<script lang="ts">
  import { cubicInOut } from "svelte/easing";
  import { crossfade } from "svelte/transition";
  import { cn } from "$lib/utils.js";
  import { page, Link } from "@inertiajs/svelte";
  import Button from "../ui/button/Buttton.svelte";

  let className: string | undefined | null = undefined;
  export let items: { href: string; title: string }[] = [];
  export { className as class };

  const [send, receive] = crossfade({
    duration: 250,
    easing: cubicInOut,
  });
</script>

<nav class={cn("flex space-x-2 lg:flex-col lg:space-x-0 lg:space-y-1", className)}>
  {#each items as item}
    {@const isActive = $page.url.pathname === item.href}

    <Link
      href={item.href}
      variant="ghost"
      class={cn(
        !isActive && "hover:underline",
        "relative justify-start hover:bg-transparent"
      )}
      data-sveltekit-noscroll
    >
      {#if isActive}
        <div
          class="bg-muted absolute inset-0 rounded-md"
          in:send={{ key: "active-sidebar-tab" }}
          out:receive={{ key: "active-sidebar-tab" }}
        />
      {/if}
      <div class="relative">
        {item.title}
      </div>
    </Link>
  {/each}
</nav>

<style>
  nav {
    background-color: var(--sidebar-background, #f8f9fa);
    padding: 1rem;
    border-right: 1px solid var(--sidebar-border, #e0e0e0);
  }

  .bg-muted {
    background-color: var(--sidebar-active-background, #e2e8f0);
  }

  .button {
    font-weight: 500;
    color: var(--sidebar-text-color, #333);
  }

  .button:hover {
    color: var(--sidebar-text-hover-color, #007bff);
  }

  .button.active {
    font-weight: 700;
  }
</style>
