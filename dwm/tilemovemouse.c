void
insertbefore(Client *a, Client *b)
{
	Client **x = &selmon->clients;

	while (*x && *x != b)
		x = &(*x)->next;

	*x = a;
	a->next = b;
}

void
insertafter(Client *a, Client *b)
{
	a->next = b->next;
	b->next = a;
}

void
tilemovemouse(const Arg *arg)
{
	Client *c, *d;
	XEvent ev;
	int x, y;
	Bool after;

	if (!(c = selmon->sel))
		return;

	if (c->isfloating || !selmon->lt[selmon->sellt]->arrange) {
		movemouse(NULL);
		return;
	}

	if (XGrabPointer(dpy, root, False, MOUSEMASK,
		GrabModeAsync, GrabModeAsync,
		None, cursor[CurMove]->cursor, CurrentTime) != GrabSuccess)
		return;

	do {
		XMaskEvent(dpy, MOUSEMASK|ExposureMask|SubstructureRedirectMask, &ev);

		switch (ev.type) {
		case ConfigureRequest:
		case Expose:
		case MapRequest:
			handler[ev.type](&ev);
			break;

		case MotionNotify:
			x = ev.xmotion.x;
			y = ev.xmotion.y;
			after = False;

			for (d = nexttiled(selmon->clients); d; d = nexttiled(d->next)) {
				if (d == c)
					after = True;
				else if (x >= d->x && x <= d->x + d->w + 2*borderpx &&
				         y >= d->y && y <= d->y + d->h + 2*borderpx) {

					detach(c);
					after ? insertafter(c, d) : insertbefore(c, d);
					arrange(selmon);
					break;
				}
			}
		}
	} while (ev.type != ButtonRelease);

	XUngrabPointer(dpy, CurrentTime);
}