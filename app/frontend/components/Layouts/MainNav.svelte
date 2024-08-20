<script lang="ts">
  import { page, Link, inertia } from '@inertiajs/svelte';
  import * as Menubar from "$lib/components/ui/menubar/index.js";
  import { Button } from "$lib/components/ui/button";
  import Sun from "svelte-radix/Sun.svelte";
  import Moon from "svelte-radix/Moon.svelte";
  import { toggleMode } from 'mode-watcher';

  // Assuming you get user data from a store or context
  import { userStore } from "../../stores/userStore";
  const { auth } = $page.props;
  export let current_user = auth.user;

  let profilePath = '';

  if (current_user) {
    if (current_user.role === 'candidate') {
      let candidate = current_user.candidate;
      profilePath = `/candidates/${candidate.id}`;
    } else if (current_user.role === 'employer') {
      let employer = current_user.employer;
      profilePath = `/employers/${employer.id}`;
    }
  }
</script>

<nav class="flex justify-between p-6 mx-auto w-full items-center">

  <!-- Home Menu -->
  <Menubar.Root class="flex justify-between">
    <div class="flex">
      <Menubar.Menu>
        <Menubar.Trigger>Home</Menubar.Trigger>
        <Menubar.Content>
          <Menubar.Item>
            <Link href="/pages/home">Home</Link>
          </Menubar.Item>
        </Menubar.Content>
      </Menubar.Menu>

      {#if $page.props.auth && $page.props.auth.user}
        <Menubar.Menu>
          <Menubar.Trigger>Jobs</Menubar.Trigger>
          <Menubar.Content>
            <Menubar.Item>
              <Link href="/jobs">Job Listings</Link>
            </Menubar.Item>
            <Menubar.Item>
              <Link href="/job_applications">My Applications</Link>
            </Menubar.Item>
            {#if current_user.role === 'employer'}
              <Menubar.Separator />
              <Menubar.Item>
                <Link href="/jobs/new">Create New Job Posting</Link>
              </Menubar.Item>
            {/if}
          </Menubar.Content>
        </Menubar.Menu>

        <!-- Events Menu -->
        <Menubar.Menu>
          <Menubar.Trigger>Events</Menubar.Trigger>
          <Menubar.Content>
            <Menubar.Item>
              <Link href="/events">Upcoming Events</Link>
            </Menubar.Item>
            <Menubar.Item>
              <Link href="/event_registrations">Registered Events</Link>
            </Menubar.Item>
            {#if current_user.role === 'employer'}
              <Menubar.Separator />
              <Menubar.Item>
                <Link href="/events/new">Host New Event</Link>
              </Menubar.Item>
            {/if}
          </Menubar.Content>
        </Menubar.Menu>
      {/if}
    </div>

    <div>
      {#if $page.props.auth && $page.props.auth.user}
        <Menubar.Menu>
          <Menubar.Trigger>
            <Button variant="outline" size="icon">
              <img
                src="https://github.com/shadcn.png"
                width={36}
                height={36}
                alt="Avatar"
                class="overflow-hidden rounded-full"
              />
            </Button>
          </Menubar.Trigger>
          <Menubar.Content>
            <Menubar.Item>
              <Link href={profilePath}>My Profile</Link>
            </Menubar.Item>
            <Menubar.Item>
              <button use:inertia="{{ href: '/logout', method: 'delete' }}">Log out</button>
            </Menubar.Item>
          </Menubar.Content>
        </Menubar.Menu>
      {:else}
        <Menubar.Menu>
          <div class="flex">
            <Menubar.Item>
              <a href="/login">Sign In</a>
            </Menubar.Item>
            <Menubar.Item>
              <a href="/sign_up">Sign Up</a>
            </Menubar.Item>
          </div>
        </Menubar.Menu>
      {/if}
    </div>

  </Menubar.Root>
</nav>
