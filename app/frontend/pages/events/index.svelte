<script lang="ts">
  import { page } from '@inertiajs/svelte';
  import { Button } from "$lib/components/ui/button/index.js";
  import * as Card from "$lib/components/ui/card/index.js";
  import * as Avatar from "$lib/components/ui/avatar";
  import { registerForEvent, unregisterForEvent } from '$lib/eventRegistrationUtils';

  export let events;
  export let current_user;

  export let user_role = $page.props.auth.user.role;

  let registeredEvents = {};

  $: events.forEach(event => {
    registeredEvents[event.id] = event.registered_by_current_user;
  });

  async function handleRegister(event) {
  if (registeredEvents[event.id]) {
    const success = await unregisterForEvent(event.id, event.name, event.employer.company_name);
    if (success) {
      console.log("unregister event")

      registeredEvents = { ...registeredEvents, [event.id]: false };
    }
  } else {
    const success = await registerForEvent(event.id, event.name, event.employer.company_name);
    if (success) {
      registeredEvents = { ...registeredEvents, [event.id]: true };
    }
  }
}

</script>

{#if user_role === 'candidate'}
  <h1 class="mx-auto my-24 text-5xl text-center">Discover the <span class="text-red-500">Best Events</span></h1>
{:else if user_role === 'employer'}
  <h1 class="mx-auto my-24 text-5xl text-center">Your <span class="text-red-500">Events </span></h1>
{/if}


<div class="grid grid-cols-1 gap-4">
  {#each events as event}
    <Card.Root class="w-full max-w-full overflow-hidden rounded-lg shadow-lg">
        <div class="w-full">
          <Card.Header class="flex p-0 pt-6 mt-4">
            <div class="flex px-4 space-x-6">
              <Avatar.Root class="w-24 h-24">
                <Avatar.Image src="{event.employer.user.profile_picture}" alt="Employer Profile Picture" class="object-cover" />
                <Avatar.Fallback></Avatar.Fallback>
              </Avatar.Root>
              <div class="self-center">
                <Card.Title class="text-xl font-bold">{event.name}</Card.Title>
                <Card.Description class="text-sm">{event.location} . <span class="text-sm">{event.status}</span></Card.Description>
              </div>
            </div>
          </Card.Header>
          <Card.Footer class="flex justify-end pb-4 border-gray-200">
            <Button href={`/events/${event.id}`} variant="outline" class="mr-2">More Details</Button>

            {#if current_user.role === 'candidate'}
              <Button
                class={`self-center ${registeredEvents[event.id] ? 'bg-green-600 text-white' : ''}`}
                on:click={() => handleRegister(event)}
              >
                {registeredEvents[event.id] ? "Registered" : "Register"}
              </Button>

            {:else if current_user.role === 'employer'}
              <Button href="/events/{event.id}/edit"> Edit Event </Button>
            {/if}
          </Card.Footer>
        </div>
    </Card.Root>
  {/each}
</div>
