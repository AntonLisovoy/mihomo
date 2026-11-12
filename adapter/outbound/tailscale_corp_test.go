//go:build with_gvisor && !no_tailscale

package outbound

import (
	"strings"
	ts "tailscale.com"
	"testing"
)

func TestCorpTailscaleVersion(t *testing.T) {
	if got := strings.TrimSpace(ts.VersionDotTxt); got != "1.104.5" {
		t.Fatalf("embedded Tailscale version = %q, want 1.104.5; review corporate compatibility before updating", got)
	}
}

func TestCorpTailscaleAcceptRoutes(t *testing.T) {
	for _, accept := range []bool{true, false} {
		prefs, err := buildTailscaleMaskedPrefs(TailscaleOption{AcceptRoutes: &accept})
		if err != nil {
			t.Fatal(err)
		}
		if prefs == nil || !prefs.RouteAllSet || prefs.RouteAll != accept {
			t.Fatalf("accept-routes=%v was not explicitly applied: %+v", accept, prefs)
		}
	}
}
