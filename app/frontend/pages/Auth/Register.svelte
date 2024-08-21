<script lang="ts">
  import { useForm } from '@inertiajs/svelte';
  import * as Tabs from "$lib/components/ui/tabs/index.js";
  import * as Card from "$lib/components/ui/card/index.js";
  import { Button } from "$lib/components/ui/button/index.js";
  import { Input } from "$lib/components/ui/input/index.js";
  import { Label } from "$lib/components/ui/label/index.js";

  let form = useForm({
    user: {
      email: null,
      password: null,
      // password_confirmation: null,
      role: 'candidate',  // Default to candidate
      first_name: null,  // Optional field
      last_name: null,  // Optional field
    }
  });

  function selectRole(role: string) {
    $form.user.role = role;  // Update role based on tab selection
    console.log("Role selected:", $form.user.role);
  }

  function submit() {
    console.log("Submitting form with role:", $form.user.role);
    $form.post('/sign_up');
  }
</script>

<Tabs.Root value="candidate" class="w-full max-w-sm mx-auto mt-10">
  <Tabs.List class="grid w-full grid-cols-2 mb-4">
    <Tabs.Trigger value="candidate" on:click={() => selectRole('candidate')} class="text-center focus:outline-none">I am looking for a job</Tabs.Trigger>
    <Tabs.Trigger value="employer" on:click={() => selectRole('employer')} class="text-center focus:outline-none">I am hiring</Tabs.Trigger>
  </Tabs.List>
  <form on:submit|preventDefault={submit}>
    <Tabs.Content value="candidate">
      <Card.Root>
        <Card.Header>
          <Card.Title class="text-2xl">Sign Up</Card.Title>
          <Card.Description>Fill in the details below to create a new account.</Card.Description>
        </Card.Header>
        <Card.Content class="space-y-4">
          {#if $form.user.role === 'candidate'}
            <div class="space-y-2">
              <Label for="first_name">First Name</Label>
              <Input id="first_name" type="text" bind:value={$form.user.first_name} placeholder="First Name" required />
              {#if $form.errors.user?.first_name}
                <div class="text-red-500 form-error">{$form.errors.user.first_name}</div>
              {/if}
            </div>
            <div class="space-y-2">
              <Label for="last_name">Last Name</Label>
              <Input id="last_name" type="text" bind:value={$form.user.last_name} placeholder="Last Name" required />
              {#if $form.errors.user?.last_name}
                <div class="text-red-500 form-error">{$form.errors.user.last_name}</div>
              {/if}
            </div>
          {/if}
          <div class="space-y-2">
            <Label for="email">Email</Label>
            <Input id="email" type="email" bind:value={$form.user.email} placeholder="Email" required />
            {#if $form.errors.user?.email}
              <div class="text-red-500 form-error">{$form.errors.user.email}</div>
            {/if}
          </div>
          <div class="space-y-2">
            <Label for="password">Password</Label>
            <Input id="password" type="password" bind:value={$form.user.password} placeholder="Password" required />
            {#if $form.errors.user?.password}
              <div class="text-red-500 form-error">{$form.errors.user.password}</div>
            {/if}
          </div>
        </Card.Content>
        <Card.Footer>
          <Button class="w-full" type="submit" disabled={$form.processing}>Sign Up</Button>
        </Card.Footer>
      </Card.Root>
    </Tabs.Content>
    <Tabs.Content value="employer">
      <Card.Root>
        <Card.Header>
          <Card.Title class="text-2xl">Company Sign Up</Card.Title>
          <Card.Description>Fill in the details below to find candidates.</Card.Description>
        </Card.Header>
        <Card.Content class="space-y-4">
          <div class="space-y-2">
            <Label for="email">Company Email</Label>
            <Input id="email" type="email" bind:value={$form.user.email} placeholder="Email" required />
            {#if $form.errors.user?.email}
              <div class="text-red-500 form-error">{$form.errors.user.email}</div>
            {/if}
          </div>
          <div class="space-y-2">
            <Label for="password">Password</Label>
            <Input id="password" type="password" bind:value={$form.user.password} placeholder="Password" required />
            {#if $form.errors.user?.password}
              <div class="text-red-500 form-error">{$form.errors.user.password}</div>
            {/if}
          </div>
        </Card.Content>
        <Card.Footer>
          <Button class="w-full" type="submit" disabled={$form.processing}>Sign Up</Button>
        </Card.Footer>
      </Card.Root>
    </Tabs.Content>
  </form>
</Tabs.Root>
