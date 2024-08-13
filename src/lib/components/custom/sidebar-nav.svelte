<script lang="ts">
  import { createEventDispatcher } from 'svelte';

  export let currentSection: string;
  export let onSectionChange: (section: string) => void;

  const dispatch = createEventDispatcher();

  function handleSectionChange(section: string) {
    dispatch('sectionChange', section);
    onSectionChange(section);
  }
</script>

<nav class="w-1/4 p-4 bg-gray-100">
  <ul class="space-y-2">
    <li>
      <button
        class="w-full p-2 text-left rounded hover:bg-gray-200"
        class:font-bold={currentSection === 'profile'}
        on:click={() => handleSectionChange('profile')}
      >
        Profile
      </button>
    </li>
    <li>
      <button
        class="w-full p-2 text-left rounded hover:bg-gray-200"
        class:font-bold={currentSection === 'account'}
        on:click={() => handleSectionChange('account')}
      >
        Account
      </button>
    </li>
    <li>
      <button
        class="w-full p-2 text-left rounded hover:bg-gray-200"
        class:font-bold={currentSection === 'appearance'}
        on:click={() => handleSectionChange('appearance')}
      >
        Appearance
      </button>
    </li>
    <li>
      <button
        class="w-full p-2 text-left rounded hover:bg-gray-200"
        class:font-bold={currentSection === 'notifications'}
        on:click={() => handleSectionChange('notifications')}
      >
        Notifications
      </button>
    </li>
    <li>
      <button
        class="w-full p-2 text-left rounded hover:bg-gray-200"
        class:font-bold={currentSection === 'display'}
        on:click={() => handleSectionChange('display')}
      >
        Display
      </button>
    </li>
  </ul>
</nav>

<style>
  button {
    cursor: pointer;
  }
</style>
