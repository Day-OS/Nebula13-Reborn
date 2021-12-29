

/obj/item/implant/deathacidifier
    name = "death acidifier"
    desc = "An implant that screams in common when you die. Useful as a head of staff."
    activated = FALSE
    allow_multiple = FALSE
    uses = 1
    //Our internal radio
    var/obj/item/radio/radio = /obj/item/radio
    //The key our internal radio uses
    var/radio_key = /obj/item/encryptionkey/ai
    //The channel we will communicate with when we die, oof
    var/channels = list(RADIO_CHANNEL_MEDICAL,RADIO_CHANNEL_SECURITY)
//a
/obj/item/implant/deathacidifier/Initialize()
    . = ..()
    if(ispath(radio))
        radio = new radio(src)
        if(radio_key)
            radio.keyslot = new radio_key(radio)
        radio.listening = FALSE
        radio.recalculateChannels()

/obj/item/implant/deathacidifier/Destroy()
    QDEL_NULL(radio)
    return ..()

/obj/item/implant/deathacidifier/implant(mob/living/target, mob/user, silent, force)
    . = ..()
    if(!.)
        return
    RegisterSignal(target, COMSIG_LIVING_DEATH, .proc/on_death)

/obj/item/implant/deathacidifier/removed(mob/living/source, silent, special)
    . = ..()
    if(!.)
        return
    UnregisterSignal(source, COMSIG_LIVING_DEATH)

/obj/item/implant/deathacidifier/proc/on_death(mob/living/owner, gibbed)

	var/T = get_turf(owner);
	new /turf/open/lava(T)
	world.log << "DAY-DEBUG: [T]";




/obj/item/implanter/deathacidifier
	name = "deathacidifier implanter"
	imp_type = /obj/item/implant/deathacidifier
	desc = "An implant that shouts in the medical and security channels whenever the owner dies"

/obj/item/implantcase/deathacidifier
	name = "implant case - 'Death Acidifierdeathacidifier'"
	desc = "A glass case containing an implant that can alert when the owner is dead."
	imp_type = /obj/item/implant/deathacidifier
