package log

type Config struct {
	Segment struct {
		MaxStoreBytes  uint64
		MaxIndexBytes  uint64
		InintialOffset uint64
	}
}
