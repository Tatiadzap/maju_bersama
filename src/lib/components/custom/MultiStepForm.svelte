<script lang="ts">
  import * as Sidebar from "$lib/components/ui/sidebar/index.js";
  import * as Tabs from "$lib/components/ui/tabs/index.js";
  import * as Card from "$lib/components/ui/card/index.js";
  import { Button } from "$lib/components/ui/button/index.js";
  import { Input } from "$lib/components/ui/input/index.js";
  import { Label } from "$lib/components/ui/label/index.js";

  let currentSection = 'account';

  function handleSectionChange(section: string) {
    currentSection = section;
  }

  // Define the sections dynamically
  let sections = [
    { href: 'profile', title: 'Profile' },
    { href: 'account', title: 'Account' },
    { href: 'appearance', title: 'Appearance' },
    { href: 'notifications', title: 'Notifications' },
    { href: 'display', title: 'Display' }
  ];
</script>

<div class="flex flex-col w-full min-h-screen lg:flex-row">
  <!-- Sidebar Component -->
  <div class="w-full text-white lg:w-64">
    <Sidebar.SidebarMenu
      currentSection={currentSection}
      onSectionChange={handleSectionChange}
      sections={sections}
    />
  </div>

  <!-- Main Content Area -->
  <main class="flex-1 px-4 text-white">
    <div class="w-full max-w-screen-lg mx-auto">
      <Tabs.Root value={currentSection} onValueChange={handleSectionChange} class="w-full">
        <!-- Consistent minimum width for Tabs.Content, responsive with max-width -->
        {#each sections as section}
          <Tabs.Content value={section.href} class="w-full mx-auto sm:max-w-3xl">
            <Card.Root class="w-full">
              <Card.Header>
                <Card.Title>{section.title}</Card.Title>
                <Card.Description>
                  <!-- Dynamic description based on section -->
                  {#if section.href === 'profile'}
                    Make changes to your profile here. Click save when you're done.
                  {:else if section.href === 'account'}
                    Make changes to your account here. Click save when you're done.
                  {:else if section.href === 'password'}
                    Change your password here. After saving, you'll be logged out.
                  {:else if section.href === 'appearance'}
                    Customize how your profile looks.
                  {:else if section.href === 'notifications'}
                    Set up your notification preferences.
                  {:else if section.href === 'display'}
                    Configure your display settings.
                  {/if}
                </Card.Description>
              </Card.Header>
              <Card.Content class="space-y-4">
                <!-- Form content can be dynamically inserted based on section -->
                {#if section.href === 'profile' || section.href === 'account'}
                  <div class="space-y-1">
                    <Label for="name">Name</Label>
                    <Input id="name" value="Pedro Duarte" class="w-full" />
                  </div>
                  <div class="space-y-1">
                    <Label for="username">Username</Label>
                    <Input id="username" value="@peduarte" class="w-full" />
                  </div>
                {:else if section.href === 'password'}
                  <div class="space-y-1">
                    <Label for="current">Current password</Label>
                    <Input id="current" type="password" class="w-full" />
                  </div>
                  <div class="space-y-1">
                    <Label for="new">New password</Label>
                    <Input id="new" type="password" class="w-full" />
                  </div>
                {/if}
                <!-- Other sections can be populated as needed -->
              </Card.Content>
              <Card.Footer>
                <Button>Save changes</Button>
              </Card.Footer>
            </Card.Root>
          </Tabs.Content>
        {/each}
      </Tabs.Root>
    </div>
  </main>
</div>
