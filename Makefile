.PHONY: release release-setup

# Upload signed builds to TestFlight and the Google Play internal track.
release:
	bundle exec fastlane release

release-setup:
	bundle install
