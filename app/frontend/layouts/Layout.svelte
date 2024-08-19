<script lang="ts">
  import { onMount } from 'svelte';
  import { ModeWatcher } from "mode-watcher";
  import MainNav from "../components/Layouts/MainNav.svelte";
  import { Toaster } from "$lib/components/ui/sonner";

  //   // Force light mode on initial load
  // onMount(() => {
  //   document.documentElement.classList.remove('dark');
  //   localStorage.setItem('theme', 'light'); // Ensure the theme is saved in local storage
  // });
</script>

<ModeWatcher defaultMode="light" />
<Toaster />

<div>
  <MainNav />
  <main>
    <div>
      <slot />
    </div>
  </main>
</div>
