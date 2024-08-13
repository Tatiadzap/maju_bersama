<script lang="ts">
  import Sidebar from '$lib/components/custom/Sidebar.svelte';
  import * as Tabs from "$lib/components/ui/tabs";
  import { onMount } from 'svelte';

  let currentSection = 'account';

  function handleSectionChange(section: string) {
    currentSection = section;
  }

  onMount(() => {
    // Any initialization or side effects if needed
  });
</script>

<div class="flex flex-col min-h-screen lg:flex-row">
  <div class="w-full lg:w-64">
    <Sidebar currentSection={currentSection} onSectionChange={handleSectionChange} />
  </div>

  <main class="flex-1 p-4 text-white bg-gray-900">
    <Tabs.Root value={currentSection} onValueChange={handleSectionChange} class="w-full lg:w-3/4">
      <Tabs.List class="flex mb-4 border-b border-gray-700">
        <Tabs.Trigger value="account" class="flex-1 py-2 text-center cursor-pointer">Account</Tabs.Trigger>
        <Tabs.Trigger value="password" class="flex-1 py-2 text-center cursor-pointer">Password</Tabs.Trigger>
        <Tabs.Trigger value="appearance" class="flex-1 py-2 text-center cursor-pointer">Appearance</Tabs.Trigger>
        <Tabs.Trigger value="notifications" class="flex-1 py-2 text-center cursor-pointer">Notifications</Tabs.Trigger>
        <Tabs.Trigger value="display" class="flex-1 py-2 text-center cursor-pointer">Display</Tabs.Trigger>
      </Tabs.List>

      <Tabs.Content value="account" class="space-y-4">
        <h2 class="text-2xl font-bold">Account</h2>
        <p class="mb-4 text-gray-400">Manage your account settings.</p>
        <!-- Account settings form -->
        <div>
          <label class="block mb-1 text-sm font-medium" for="email">Email</label>
          <select id="email" class="input">
            <option>Select a verified email to display</option>
          </select>
        </div>
        <button type="submit" class="w-full mt-6 lg:w-auto btn-primary">Save changes</button>
      </Tabs.Content>

      <Tabs.Content value="password" class="space-y-4">
        <h2 class="text-2xl font-bold">Password</h2>
        <p class="mb-4 text-gray-400">Change your password here.</p>
        <!-- Password settings form -->
        <div>
          <label class="block mb-1 text-sm font-medium" for="current-password">Current Password</label>
          <input id="current-password" type="password" class="input" />
        </div>
        <div>
          <label class="block mb-1 text-sm font-medium" for="new-password">New Password</label>
          <input id="new-password" type="password" class="input" />
        </div>
        <button type="submit" class="w-full mt-6 lg:w-auto btn-primary">Change Password</button>
      </Tabs.Content>

      <Tabs.Content value="appearance" class="space-y-4">
        <h2 class="text-2xl font-bold">Appearance</h2>
        <p class="mb-4 text-gray-400">Customize how your profile looks.</p>
        <!-- Appearance settings form -->
      </Tabs.Content>

      <Tabs.Content value="notifications" class="space-y-4">
        <h2 class="text-2xl font-bold">Notifications</h2>
        <p class="mb-4 text-gray-400">Set up your notification preferences.</p>
        <!-- Notifications settings form -->
      </Tabs.Content>

      <Tabs.Content value="display" class="space-y-4">
        <h2 class="text-2xl font-bold">Display</h2>
        <p class="mb-4 text-gray-400">Configure your display settings.</p>
        <!-- Display settings form -->
      </Tabs.Content>
    </Tabs.Root>
  </main>
</div>

<style>
  .input {
    width: 100%;
    padding: 0.75rem;
    background-color: #1e1e1e;
    border: 1px solid #333;
    border-radius: 4px;
    color: #fff;
  }

  .btn-primary {
    background-color: #0066cc;
    color: white;
    padding: 0.75rem 1.5rem;
    text-align: center;
    border-radius: 4px;
    cursor: pointer;
  }

  .btn-primary:hover {
    background-color: #005bb5;
  }
</style>
