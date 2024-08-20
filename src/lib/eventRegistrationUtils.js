import { toast } from "svelte-sonner";

export async function registerForEvent(eventId, eventName, companyName) {
  try {
    const response = await fetch("/event_registrations", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify({
        event_registration: {
          event_id: eventId,
        },
      }),
    });

    if (response.ok) {
      toast.success(`Registered for ${eventName} at ${companyName}!`);
      return true;
    } else {
      const errorData = await response.json();
      if (
        response.status === 422 &&
        errorData.message === "already_registered"
      ) {
        toast.error(
          `You have already registered for ${eventName} at ${companyName}`
        );
      } else {
        toast.error(
          `Failed to register: ${errorData.errors ? errorData.errors.join(", ") : "Unknown error"}`
        );
      }
      return false;
    }
  } catch (error) {
    toast.error(`An error occurred: ${error.message}`);
    return false;
  }
}

export async function unregisterForEvent(eventId, eventName, companyName) {
  try {
    const response = await fetch(`/event_registrations/${eventId}`, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
    });

    if (response.ok) {
      toast.success(`Unregistered from ${eventName} at ${companyName}.`);
      return true;
    } else {
      const errorData = await response.json();
      toast.error(
        `Failed to unregister: ${errorData.errors ? errorData.errors.join(", ") : "Unknown error"}`
      );
      return false;
    }
  } catch (error) {
    toast.error(`An error occurred: ${error.message}`);
    return false;
  }
}

export async function handleRegister(
  event,
  registeredEvents,
  setRegisteredEvents
) {
  if (registeredEvents[event.id]) {
    const success = await unregisterForEvent(
      event.id,
      event.name,
      event.employer.company_name
    );
    if (success) {
      setRegisteredEvents({ ...registeredEvents, [event.id]: false });
    }
    return success;
  } else {
    const success = await registerForEvent(
      event.id,
      event.name,
      event.employer.company_name
    );
    if (success) {
      setRegisteredEvents({ ...registeredEvents, [event.id]: true });
    }
    return success;
  }
}
