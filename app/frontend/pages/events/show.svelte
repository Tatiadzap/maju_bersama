<script lang="ts">
  import { page } from '@inertiajs/svelte';
  import { handleRegister } from '$lib/eventRegistrationUtils';
  import { Button } from "$lib/components/ui/button";
  import dayjs from 'dayjs';

  // Data passed from Rails
  export let event;

  // Extract employer and company_details from event
  export let employer = event?.employer || {};
  export let company_details = event?.company_details || {};

  // Manage the registration state similar to the index component
  let registeredEvents = { [event.id]: event?.registered_by_current_user };

  function setRegisteredEvents(updatedEvents) {
    registeredEvents = updatedEvents;
  }

  // Authenticated user details
  const { auth } = $page.props;
  export let current_user = auth.user;

  // Format start and end dates using dayjs
  $: formattedStartDate = event?.start_time ? dayjs(event.start_time).format('D MMMM YYYY, hh:mm A') : '';
  $: formattedEndDate = event?.end_time ? dayjs(event.end_time).format('D MMMM YYYY, hh:mm A') : '';

  // Function to handle registration click
  async function onRegisterClick() {
    await handleRegister(event, registeredEvents, setRegisteredEvents);
  }
</script>

<!-- Component HTML -->
<div class="flex justify-between py-12">
  <div class="flex space-x-4">
    <img src={company_details.profile_picture} alt="Company Logo" class="w-24 h-24">
    <div class="flex flex-col justify-center">
      <p class="text-xl font-medium">{event.name}</p>
      <div class="flex space-x-6">
        <p>{employer.company_name || "Unknown Company"}</p>
        <p>{event.location}</p>
        <p>{formattedStartDate}</p>
      </div>
    </div>
  </div>

  <!-- Registration or Edit Button -->
  {#if current_user.role === 'candidate'}
    <Button
      class={`self-center ${registeredEvents[event.id] ? 'bg-green-600 text-white' : 'bg-blue-300 text-black'}`}
      on:click={onRegisterClick}
    >
      {registeredEvents[event.id] ? "Registered" : "Register"}
    </Button>
  {:else if current_user.role === 'employer'}
    <Button href={`/events/${event.id}/edit`} class="bg-blue-500 text-white">Edit Event</Button>
  {/if}
</div>

<div class="w-full h-0.5 bg-gray-200"></div>

<div class="flex my-12">
  <div class="space-y-12 flex-basis-2/3">
    <div>
      <h2 class="mb-2 text-lg font-medium">Description</h2>
      <p>{event.description}</p>
    </div>

    <div class="space-y-2">
      <h2 class="mb-2 text-lg font-medium">Details</h2>
      <p>Location: {event.location}</p>
      <p>Start: {formattedStartDate}</p>
      <p>End: {formattedEndDate}</p>
    </div>
  </div>
</div>
