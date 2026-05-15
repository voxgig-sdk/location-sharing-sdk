<?php
declare(strict_types=1);

// LocationSharing SDK base feature

class LocationSharingBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(LocationSharingContext $ctx, array $options): void {}
    public function PostConstruct(LocationSharingContext $ctx): void {}
    public function PostConstructEntity(LocationSharingContext $ctx): void {}
    public function SetData(LocationSharingContext $ctx): void {}
    public function GetData(LocationSharingContext $ctx): void {}
    public function GetMatch(LocationSharingContext $ctx): void {}
    public function SetMatch(LocationSharingContext $ctx): void {}
    public function PrePoint(LocationSharingContext $ctx): void {}
    public function PreSpec(LocationSharingContext $ctx): void {}
    public function PreRequest(LocationSharingContext $ctx): void {}
    public function PreResponse(LocationSharingContext $ctx): void {}
    public function PreResult(LocationSharingContext $ctx): void {}
    public function PreDone(LocationSharingContext $ctx): void {}
    public function PreUnexpected(LocationSharingContext $ctx): void {}
}
