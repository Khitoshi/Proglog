package log

import (
	"os"

	"github.com/tysontate/gommap"
)

const (
	offWidth  uint64 = 8
	posWidth  uint64 = 8
	entWWidth uint64 = offWidth + posWidth
)

type index struct {
	file *os.File
	mmap gommap.MMap
	size uint64
}
