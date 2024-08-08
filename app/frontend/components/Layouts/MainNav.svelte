<script>
  import { Link, inertia, page } from '@inertiajs/svelte';
  import * as DropdownMenu from "$lib/components/ui/dropdown-menu";
  import { Button } from "$lib/components/ui/button";
  import { userStore } from "../../stores/userStore";
  import Sun from "svelte-radix/Sun.svelte";
  import Moon from "svelte-radix/Moon.svelte";
  import { toggleMode } from 'mode-watcher';

  // Access shared instance props from Inertia
  const { auth } = $page.props;
  export let current_user = auth.user;

  let profilePath = '';
  // let userSpecificData = '';

  if (current_user) {
    if (current_user.role === 'candidate') {
      let candidate = current_user.candidate
      profilePath = `/candidates/${candidate.id}`;
    } else if (current_user.role === 'employer') {
      let employer = current_user.employer
      profilePath = `/employers/${employer.id}`;
    }
  }

</script>

<nav class="flex justify-between p-6 mx-auto max-w-7xl">
  <ul class="flex items-center space-x-8">
    <li>
      <Link href="/">Home</Link>
    </li>
    <li>
      <Link href="/jobs">Jobs</Link>
    </li>
    <li>
      <Link href="/events">Events</Link>
    </li>
    <li>
      <Link href="/job_applications">Job Applications</Link>
    </li>
  </ul>

  <div class="flex items-center space-x-2">
    {#if $page.props.auth && $page.props.auth.user}
      <!-- <div>{$page.props.auth.user.first_name}</div> -->
      {#if current_user.role === 'employer'}
        <Link href="/jobs/new">+ New Job</Link>
      {/if}

      <DropdownMenu.Root>
        <DropdownMenu.Trigger asChild let:builder>
          <Button
            variant="outline"
            size="icon"
            class="overflow-hidden rounded-full"
            builders={[builder]}
          >
            <img
              src="https://github.com/shadcn.png"
              width={36}
              height={36}
              alt="Avatar"
              class="overflow-hidden rounded-full"
            />
          </Button>
        </DropdownMenu.Trigger>
        <DropdownMenu.Content align="end">
          <DropdownMenu.Item>
            <button use:inertia="{{ href: `/candidates/${current_user.id}`}}" type="button" class="w-full text-left">
              My profile
            </button>
          </DropdownMenu.Item>
          <DropdownMenu.Separator />
          <DropdownMenu.Item>Settings</DropdownMenu.Item>
          <DropdownMenu.Item>Support</DropdownMenu.Item>
          <DropdownMenu.Separator />
          <DropdownMenu.Item>
            <button use:inertia="{{ href: '/logout', method: 'delete' }}" type="button" class="w-full text-left">
              Sign out
            </button>
          </DropdownMenu.Item>
        </DropdownMenu.Content>
      </DropdownMenu.Root>
    {:else}
      <Link href="/login">Sign in</Link>
      <Link href="/sign_up">Sign up</Link>
    {/if}
      <div>
        <Button on:click={toggleMode} variant="outline" size="icon">
          <Sun
            class="h-[1.2rem] w-[1.2rem] rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0"
          />
          <Moon
            class="absolute h-[1.2rem] w-[1.2rem] rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100"
          />
          <span class="sr-only">Toggle theme</span>
        </Button>
      </div>
  </div>
</nav>
